import os

from flask import Flask

from flask.ext.login import current_user
from flask.ext.principal import identity_loaded, UserNeed, RoleNeed

from wfdb.models import (
    db,
    User,
    Post,
    Actor,
    Role,
    MovieRole,
    Movie,
    Tag,
    Comment
)
from wfdb.extensions import login_manager, principal, rest_api, admin
from wfdb.controllers.main import main_blueprint
from wfdb.controllers.blog import blog_blueprint

from wfdb.controllers.rest.movie import MovieAPI
from wfdb.controllers.rest.actor import ActorAPI
from wfdb.controllers.rest.auth import AuthAPI

from wfdb.controllers.admin import CustomView, CustomModelView, UserView, ActorView, CustomFileView

def create_app(config_object):
    app = Flask(__name__)
    app.config.from_object(config_object)

    db.init_app(app)
    login_manager.init_app(app)
    principal.init_app(app)
    admin.init_app(app)

    rest_api.add_resource(
        MovieAPI,
        '/api/movie',
        '/api/movie/<int:movie_id>',
    )
    rest_api.add_resource(
        ActorAPI,
        '/api/actor',
        '/api/actor/<int:actor_id>',
    )
    rest_api.add_resource(
        AuthAPI,
        '/api/auth',
    )

    rest_api.init_app(app)

    app.register_blueprint(main_blueprint)
    app.register_blueprint(blog_blueprint)
    
    admin.add_view(
        CustomView()
    )
    admin.add_view(
        UserView(
            User, db.session
        )
    )
    admin.add_view(
        CustomModelView(
            Role, db.session
        )
    )
    admin.add_view(
        ActorView(
            Actor, db.session
        )
    )
    admin.add_view(
        CustomModelView(
            Movie, db.session
        )
    )
    admin.add_view(
        CustomModelView(
            MovieRole, db.session
        )
    )
    admin.add_view(
        CustomModelView(
            Post, db.session
        )
    )
    admin.add_view(
        CustomModelView(
            Comment, db.session
        )
    )

    static_dir = os.path.join(os.path.dirname(__file__), 'static')
    admin.add_view(
        CustomFileView(
            static_dir,
            '/static/',
            name="Static Files"
        )
    )

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
