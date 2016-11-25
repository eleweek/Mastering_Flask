from flask_wtf import FlaskForm
from wtforms import TextAreaField, PasswordField, StringField
from wtforms import validators
from wfdb.models import User

class CommentForm(FlaskForm):
    text = TextAreaField(u'Text', validators=[
        validators.required(),
        validators.Length(max=2000)
    ])

class LoginForm(FlaskForm):
    username = StringField(
        'Username',
        validators=[validators.DataRequired()]
    )
    password = PasswordField(
        'Password',
        validators=[validators.DataRequired()]
    )

    def validate(self):
        check_validate = super(LoginForm, self).validate()
        if not check_validate:
            return False

        user = User.query.filter_by(username=self.username.data).first()
        if not user:
            self.username.errors.append('Invalid username')
            return False

        if not user.check_password(self.password.data):
            self.password.errors.append('Invalid password')
            return False

        return True


class RegisterForm(FlaskForm):
    username = StringField(
        'Username',
        validators=[validators.DataRequired(), validators.Length(max=255)]
    )
    password = PasswordField(
        'Password',
        validators=[validators.DataRequired(), validators.Length(min=8)]
    )
    confirm = PasswordField(
        'Confirm Password',
        [validators.DataRequired(), validators.EqualTo('password')]
    )

    def validate(self):
        check_validate = super(RegisterForm, self).validate()
        if not check_validate:
            return False

        user = User.query.filter_by(username=self.username.data).first()

        if user:
            self.username.errors.append("User with that name already exists")
            return False

        return True