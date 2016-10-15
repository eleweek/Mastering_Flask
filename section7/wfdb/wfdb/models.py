from flask.ext.sqlalchemy import SQLAlchemy
from flask.ext.login import UserMixin
from werkzeug.security import generate_password_hash, check_password_hash

db = SQLAlchemy()

tags = db.Table(
    'post_tags',
    db.Column('post_id', db.Integer, db.ForeignKey('post.id')),
    db.Column('tag_id', db.Integer, db.ForeignKey('tag.id'))
)


roles = db.Table(
    'role_users',
    db.Column('user_id', db.Integer, db.ForeignKey('user.id')),
    db.Column('role_id', db.Integer, db.ForeignKey('role.id'))
)

class User(db.Model, UserMixin):
    id = db.Column(db.Integer(), primary_key=True)
    username = db.Column(db.String(), unique=True)
    password = db.Column(db.String())
    active = db.Column(db.Boolean(), nullable=True)
    posts = db.relationship('Post', backref='user', lazy='dynamic')
    comments = db.relationship('Comment', backref='user', lazy='dynamic')
    roles = db.relationship(
        'Role',
        secondary=roles,
        backref=db.backref('users', lazy='dynamic')
    )

    def set_password(self, password):
        self.password = generate_password_hash(password)

    def check_password(self, value):
        return check_password_hash(self.password, value)

    def is_active(self):
        return self.active is None or self.active 

    def get_id(self):
        return self.id

    def __repr__(self):
        return '<User {}>'.format(self.username)


class Role(db.Model):
    id = db.Column(db.Integer(), primary_key=True)
    name = db.Column(db.String(40), unique=True)
    description = db.Column(db.String(225))

    def __repr__(self):
        return '<Role {}>'.format(self.name)


class Actor(db.Model):
    id = db.Column(db.Integer(), primary_key=True)
    first_name = db.Column(db.String())
    last_name = db.Column(db.String())
    birthday = db.Column(db.Date())
    deathday = db.Column(db.Date())
    hometown = db.Column(db.String())
    bio = db.Column(db.Text())
    picture = db.Column(db.String())
    roles = db.relationship("MovieRole", backref="actor")
    directorships = db.relationship(
        'Movie',
        backref='director',
        lazy='dynamic'
    )

    def __repr__(self):
        return '<Actor {} {}>'.format(self.first_name, self.last_name)


class Movie(db.Model):
    id = db.Column(db.Integer(), primary_key=True)
    name = db.Column(db.String())
    release_date = db.Column(db.Date())
    director_id = db.Column(db.Integer(), db.ForeignKey('actor.id'))
    summary = db.Column(db.Text())

    def __repr__(self):
        return '<Movie {}>'.format(self.name)


class MovieRole(db.Model):
    id = db.Column(db.Integer(), primary_key=True)
    actor_id = db.Column(db.Integer, db.ForeignKey('actor.id'))
    movie_id = db.Column(db.Integer, db.ForeignKey('movie.id'))
    role_name = db.Column(db.String())
    movie = db.relationship("Movie", backref="cast")

    def __repr__(self):
        return '<MovieRole {}>'.format(self.role_name)


class Post(db.Model):
    id = db.Column(db.Integer(), primary_key=True)
    title = db.Column(db.String())
    text = db.Column(db.Text())
    publish_date = db.Column(db.DateTime())
    user_id = db.Column(db.Integer(), db.ForeignKey('user.id'))
    comments = db.relationship(
        'Comment',
        backref='post',
        lazy='dynamic'
    )
    tags = db.relationship(
        'Tag',
        secondary=tags,
        backref=db.backref('posts', lazy='dynamic'),
        lazy='dynamic'
    )

    def __repr__(self):
        return "<Post '{}'>".format(self.title)


class Tag(db.Model):
    id = db.Column(db.Integer(), primary_key=True)
    title = db.Column(db.String())

    def __repr__(self):
        return "<Tag '{}'>".format(self.title)


class Comment(db.Model):
    id = db.Column(db.Integer(), primary_key=True)
    text = db.Column(db.Text())
    date = db.Column(db.DateTime())
    post_id = db.Column(db.Integer(), db.ForeignKey('post.id'))
    user_id = db.Column(db.Integer(), db.ForeignKey('user.id'))

    def __repr__(self):
        return '<Comment {}>'.format(self.text[:15])

