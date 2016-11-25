import unittest

from wfdb.models import db, User, Role
from . import app


class TestUrls(unittest.TestCase):
    def setUp(self):
        db.app = app
        db.create_all()

        self.client = app.test_client()

    def tearDown(self):
        db.session.remove()
        db.drop_all()

    def test_home(self):
        result = self.client.get('/')
        assert result.status_code == 200


    def test_admin_logged_out(self):
        result = self.client.get('/admin/user/')
        assert result.status_code == 403

    def test_login(self):
        test_user = User()
        test_user.username = "test"
        test_user.set_password("password")
        db.session.add(test_user)
        db.session.commit()

        result = self.client.post('/login', data=dict(
            username='test',
            password="password"
        ), follow_redirects=True)

        assert b'Logged in successfully.' in result.get_data()

    def test_admin_logged_in(self):
        test_user = User()
        test_user.username = "test"
        test_user.set_password("password")

        admin = Role()
        admin.name = 'admin'

        test_user.roles.append(admin)

        db.session.add(test_user)
        db.session.commit()

        result = self.client.post('/login', data=dict(
            username='test',
            password="password"
        ), follow_redirects=True)

        result = self.client.get('/admin/user/')

        assert result.status_code == 200
