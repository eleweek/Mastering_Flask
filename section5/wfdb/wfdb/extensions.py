from flask.ext.login import LoginManager
from flask.ext.principal import Principal, Permission, RoleNeed

from wfdb.models import User

login_manager = LoginManager()
login_manager.login_view = "main.login"

principal = Principal()
admin_permission = Permission(RoleNeed('admin'))
default_permission = Permission(RoleNeed('default'))

@login_manager.user_loader
def load_user(userid):
    return User.query.get(userid)