import unittest

from . import app

class TestConfig(unittest.TestCase):
    def test_config_loading(self):
        assert app.config['DEBUG'] is True
        assert app.config['SQLALCHEMY_DATABASE_URI'] == 'sqlite://'