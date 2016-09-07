from flask import Flask, render_template
from flask.ext.sqlalchemy import SQLAlchemy
from flask_wtf import Form
from wtforms import TextAreaField
from wtforms import validators
import datetime

app = Flask(__name__)
app.config['SQLALCHEMY_DATABASE_URI'] = "sqlite:///database.db"
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
app.config['SECRET_KEY'] = 'XMLZODSHE8N6NFOZDPZA2HULWSIYJU45K6N4ZO9M'
app.config['DEBUG'] = None

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
    comments = db.relationship('Comment', backref='user', lazy='dynamic')
    
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


class CommentForm(Form):
    text = TextAreaField(u'Text', validators=[
        validators.required(),
        validators.Length(max=2000)
    ])


@app.route("/")
def home():
    latest_movies = Movie.query.order_by(
        Movie.release_date.desc()
    ).limit(5).all()

    return render_template("index.html", latest_movies=latest_movies)

@app.route("/actor/<int:actor_id>")
def actor(actor_id):
    actor = Actor.query.get_or_404(actor_id)

    return render_template("actor.html", actor=actor)


@app.route("/movie/<int:movie_id>")
def movie(movie_id):
    movie = Movie.query.get_or_404(movie_id)

    return render_template("movie.html", movie=movie)


@app.route("/blog")
def blog():
    posts = Post.query.order_by(Post.publish_date.desc()).all()

    return render_template("blog.html", posts=posts)


@app.route("/blog/<int:post_id>", methods=["GET", "POST"])
def post(post_id):
    post = Post.query.get_or_404(post_id)
    
    form = CommentForm()
    if form.validate_on_submit():
        comment = Comment()
        comment.text = form.text.data
        comment.date = datetime.datetime.now()
        comment.post = post
        comment.user = User.query.get(1)

        db.session.add(comment)
        db.session.commit()

    return render_template("post.html", post=post, form=form)

if __name__ == "__main__":
    app.run(debug=True)
