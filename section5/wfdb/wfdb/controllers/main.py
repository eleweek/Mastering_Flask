from flask import render_template, Blueprint, redirect, request, flash, url_for, current_app
from flask.ext.login import login_user, logout_user, login_required
from flask.ext.principal import (
    Identity,
    AnonymousIdentity,
    identity_changed
)

from wfdb.models import db, Movie, Actor, User, Role
from wfdb.forms import LoginForm, RegisterForm
from wfdb.extensions import admin_permission

main_blueprint = Blueprint(
    'main',
    __name__,
    template_folder='../templates/main'
)

@main_blueprint.route("/")
def home():
    latest_movies = Movie.query.order_by(
        Movie.release_date.desc()
    ).limit(5).all()

    return render_template("index.html", latest_movies=latest_movies)

@main_blueprint.route("/login", methods=["GET", "POST"])
def login():
    form = LoginForm()

    if form.validate_on_submit():
        user = User.query.filter_by(username=form.username.data).one()

        login_user(user)
        identity_changed.send(
            current_app._get_current_object(),
            identity=Identity(user.id)
        )

        flash("Logged in successfully.", "success")
        return redirect(request.args.get("next") or url_for(".home"))

    return render_template("login.html", form=form)


@main_blueprint.route("/logout")
def logout():
    logout_user()
    identity_changed.send(
        current_app._get_current_object(),
        identity=AnonymousIdentity()
    )

    return redirect(url_for('.home'))

@main_blueprint.route("/register", methods=["GET", "POST"])
def register():
    form = RegisterForm()

    if form.validate_on_submit():
        user = User()
        user.username = form.username.data
        user.set_password(form.password.data)
        user.active = True
        default_role = Role.query.filter_by(name="default").first()
        user.roles.append(default_role)

        db.session.add(user)
        db.session.commit()

        flash("Your user has been created, please login.", category="success")
        return redirect(url_for(".login"))

    return render_template("register.html", form=form)


@main_blueprint.route("/actor/<int:actor_id>")
def actor(actor_id):
    actor = Actor.query.get_or_404(actor_id)

    return render_template("actor.html", actor=actor)


@main_blueprint.route("/movie/<int:movie_id>")
def movie(movie_id):
    movie = Movie.query.get_or_404(movie_id)

    return render_template("movie.html", movie=movie)


@main_blueprint.route("/restricted")
@login_required
@admin_permission.require(http_exception=403)
def restricted():
    return "hello from restricted page"
