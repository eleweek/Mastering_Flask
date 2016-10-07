from flask import Flask

from flask.ext.login import current_user
from flask.ext.principal import identity_loaded, UserNeed, RoleNeed

from wfdb.models import db
from wfdb.extensions import login_manager, principal
from wfdb.controllers.main import main_blueprint
from wfdb.controllers.blog import blog_blueprint

def create_app(config_object):
    app = Flask(__name__)
    app.config.from_object(config_object)

    db.init_app(app)
    login_manager.init_app(app)
    principal.init_app(app)

    app.register_blueprint(main_blueprint)
    app.register_blueprint(blog_blueprint)


    @identity_loaded.connect_via(app)
    def on_identity_loaded(sender, identity):
        # Set the identity user object
        identity.user = current_user

        # Add the UserNeed to the identity
        if hasattr(current_user, 'id'):
            identity.provides.add(UserNeed(current_user.id))

        # Add each role to the identity
        if hasattr(current_user, 'roles'):
            for role in current_user.roles:
                identity.provides.add(RoleNeed(role.name))

    return app

if __name__ == "__main__":
    app.run(debug=True)
