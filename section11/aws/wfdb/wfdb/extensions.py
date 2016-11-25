from flask_login import LoginManager
from flask_principal import Principal, Permission, RoleNeed
from flask_restful import Api
from flask_admin import Admin
from flask_debugtoolbar import DebugToolbarExtension
from flask_caching import Cache
from flask_assets import Environment

from flask_celery import Celery
from celery.backends.redis import RedisBackend

from wfdb.models import User

login_manager = LoginManager()
login_manager.login_view = "main.login"

principal = Principal()
admin_permission = Permission(RoleNeed('admin'))
default_permission = Permission(RoleNeed('default'))

rest_api = Api()
admin = Admin()
toolbar = DebugToolbarExtension()
cache = Cache()
assets_env = Environment()

celery = Celery()
celery.backend = RedisBackend(app=celery)

@login_manager.user_loader
def load_user(userid):
    return User.query.get(userid)