import datetime
from flask import render_template, Blueprint, abort
from flask.ext.login import current_user

from wfdb.models import db, Post, Comment, User
from wfdb.forms import CommentForm


blog_blueprint = Blueprint(
    'blog',
    __name__,
    template_folder='../templates/blog',
    url_prefix="/blog"
)


@blog_blueprint.route("/")
def blog():
    posts = Post.query.order_by(Post.publish_date.desc()).all()

    return render_template("blog.html", posts=posts)


@blog_blueprint.route("/<int:post_id>", methods=["GET", "POST"])
def post(post_id):
    post = Post.query.get_or_404(post_id)
    
    form = CommentForm()
    if form.validate_on_submit():
        if current_user.is_anonymous:
            abort(403)
        comment = Comment()
        comment.text = form.text.data
        comment.date = datetime.datetime.now()
        comment.post = post
        comment.user = current_user

        db.session.add(comment)
        db.session.commit()

    return render_template("post.html", post=post, form=form)
