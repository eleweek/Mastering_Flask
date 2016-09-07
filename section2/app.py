from flask import Flask, render_template
from flask.ext.sqlalchemy import SQLAlchemy

app = Flask(__name__)
app.config['SQLALCHEMY_DATABASE_URI'] = "sqlite:///database.db"
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False

db = SQLAlchemy(app)

tags = db.Table(
    'post_tags',
    db.Column('post_id', db.Integer, db.ForeignKey('post.id')),
    db.Column('tag_id', db.Integer, db.ForeignKey('tag.id'))
)

class User(db.Model):
    id = db.Column(db.Integer(), primary_key=True)
    username = db.Column(db.String(), unique=True)
    password = db.Column(db.String())
    posts = db.relationship('Post', backref='user', lazy='dynamic')
    
    def __repr__(self):
        return '<User {}>'.format(self.username)

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
    name = db.Column(db.String())
    text = db.Column(db.Text())
    date = db.Column(db.DateTime())
    post_id = db.Column(db.Integer(), db.ForeignKey('post.id'))

    def __repr__(self):
        return '<Comment {}>'.format(self.text[:15])


@app.route("/")
def home():
    return render_template("index.html")

if __name__ == "__main__":
    app.run(debug=True)
