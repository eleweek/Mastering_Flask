import datetime

from flask.ext.restful import Resource, fields, marshal_with, abort

from wfdb.models import db, Movie, Actor

from .parsers import movie_post_parser, movie_put_parser
from .auth import abort_if_no_admin_auth

movie_fields = {
    'id': fields.Integer(),
    'name': fields.String(),
    'summary': fields.String(),
    'release_date': fields.DateTime(dt_format='iso8601'),
    'director_id': fields.Integer()
}

class MovieAPI(Resource):
    @marshal_with(movie_fields)
    def get(self, movie_id=None):
        if movie_id:
            return Movie.query.get_or_404(movie_id)
        else:
            return Movie.query.all()

    def post(self, movie_id=None):
        if movie_id:
            abort(400)
        else:
            args = movie_post_parser.parse_args(strict=True)
            abort_if_no_admin_auth(args['token'])
            
            new_movie = Movie()
            new_movie.name = args['name']
            new_movie.summary = args['summary']
            new_movie.release_date = datetime.datetime.strptime(
                args['release_date'],
                "%Y-%m-%d"
            ).date()

            director_id = args['director_id']
            director = Actor.query.get(director_id)
            if director is None:
                abort(400, message="Director with id {} doesn't exist".format(director_id))
            new_movie.director = director

            db.session.add(new_movie)
            db.session.commit()

            return {"result": new_movie.id}, 201

    def put(self, movie_id=None):
        if not movie_id:
            abort(400)
        else:
            args = movie_put_parser.parse_args()
            abort_if_no_admin_auth(args['token'])
            
            movie = Movie.query.get_or_404(movie_id)

            if args['name']:
                movie.name = args['name']

            if args['summary']:
                movie.summary = args['summary']

            if args['release_date']:
                movie.release_date = datetime.datetime.strptime(
                    args['release_date'],
                    "%Y-%m-%d"
                ).date()

            if args['director_id']:
                director_id = args['director_id']
                director = Actor.query.get(director_id)
                if director is None:
                    abort(400, message="Director with id {} doesn't exist".format(director_id))
                movie.director = director

            db.session.add(movie)
            db.session.commit()

            return {"result": movie.id}, 201

    def delete(self, movie_id=None):
        if not movie_id:
            abort(400)
        
        args = token_parser.parse_args(strict=True)
        abort_if_no_admin_auth(args['token'])

        movie = Movie.query.get_or_404(movie_id)

        db.session.delete(movie)
        db.session.commit()
        return "", 204