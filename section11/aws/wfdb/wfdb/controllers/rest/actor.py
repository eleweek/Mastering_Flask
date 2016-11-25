import datetime

from flask import abort
from flask_restful import Resource, fields, marshal_with

from wfdb.models import db, Actor
from .parsers import actor_post_parser, actor_put_parser
from .auth import abort_if_no_admin_auth

nested_role_fields = {
    'movie_id': fields.Integer(),
    'role_name': fields.String()
}

actor_fields = {
    'id': fields.Integer(),
    'first_name': fields.String(),
    'last_name': fields.String(),
    'birthday': fields.DateTime(dt_format='iso8601'),
    'deathday': fields.DateTime(dt_format='iso8601'),
    'hometown': fields.String(),
    'bio': fields.String(),
    'roles': fields.List(fields.Nested(nested_role_fields)),
}


class ActorAPI(Resource):
    @marshal_with(actor_fields)
    def get(self, actor_id=None):
        if actor_id:
            return Actor.query.get_or_404(actor_id)
        else:
            return Actor.query.all()

    def post(self, actor_id=None):
        if actor_id:
            abort(400)
        else:
            args = actor_post_parser.parse_args(strict=True)
            abort_if_no_admin_auth(args['token'])

            new_actor = Actor()
            new_actor.first_name = args['first_name']
            new_actor.last_name = args['last_name']
            new_actor.birthday = datetime.datetime.strptime(
                args['birthday'],
                "%Y-%m-%d"
            ).date()

            if args['deathday']:
                new_actor.deathday = datetime.datetime.strptime(
                    args['deathday'],
                    "%Y-%m-%d"
                ).date()

            if args['hometown']:
                new_actor.hometown = args['hometown']

            if args['bio']:
                new_actor.bio = args['bio']

            db.session.add(new_actor)
            db.session.commit()

            return {"result": new_actor.id}, 201

    def put(self, actor_id=None):
        if not actor_id:
            abort(400)
        else:
            args = actor_put_parser.parse_args()
            abort_if_no_admin_auth(args['token'])

            actor = Actor.query.get_or_404(actor_id)

            if args['first_name']:
                actor.first_name = args['first_name']

            if args['last_name']:
                actor.last_name = args['last_name']

            if args['birthday']:
                actor.birthday = datetime.datetime.strptime(
                    args['birthday'],
                    "%Y-%m-%d"
                ).date()

            if args['deathday']:
                actor.deathday = datetime.datetime.strptime(
                    args['deathday'],
                    "%Y-%m-%d"
                ).date()

            if args['hometown']:
                actor.hometown = args['hometown']

            if args['bio']:
                actor.bio = args['bio']

            db.session.add(actor)
            db.session.commit()

            return {"result": actor.id}, 201

    def delete(self, actor_id=None):
        if not actor_id:
            abort(400)

        args = token_parser.parse_args(strict=True)
        abort_if_no_admin_auth(args['token'])

        actor = Actor.query.get_or_404(actor_id)

        db.session.delete(actor)
        db.session.commit()
        return "", 204