from flask.ext.login import LoginManager
from flask.ext.principal import Principal, Permission, RoleNeed
from flask.ext.restful import Api
from flask.ext.admin import Admin
from flask_debugtoolbar import DebugToolbarExtension
from flask.ext.cache import Cache
from flask.ext.assets import Environment

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

@login_manager.user_loader
def load_user(userid):
    return User.query.get(userid)