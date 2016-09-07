from flask import render_template, Blueprint
from wfdb.models import Movie, Actor

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

@main_blueprint.route("/actor/<int:actor_id>")
def actor(actor_id):
    actor = Actor.query.get_or_404(actor_id)

    return render_template("actor.html", actor=actor)


@main_blueprint.route("/movie/<int:movie_id>")
def movie(movie_id):
    movie = Movie.query.get_or_404(movie_id)

    return render_template("movie.html", movie=movie)

