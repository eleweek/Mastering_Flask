from flask_wtf import Form
from wtforms import TextAreaField
from wtforms import validators

class CommentForm(Form):
    text = TextAreaField(u'Text', validators=[
        validators.required(),
        validators.Length(max=2000)
    ])