import os

from flask import request
from werkzeug import secure_filename

from flask_login import current_user

from flask_admin import BaseView, expose
from flask_admin.contrib.sqla import ModelView
from flask_admin.contrib.fileadmin import FileAdmin

from wtforms.fields import FileField

from wfdb.extensions import admin_permission

class CustomView(BaseView):
    @expose('/')
    def index(self):
        return self.render('admin/custom.html')
    
    def is_accessible(self):
        return current_user.is_authenticated and admin_permission.can()


class CustomModelView(ModelView):
    def is_accessible(self):
        return current_user.is_authenticated and admin_permission.can()

class UserView(CustomModelView):
    column_list = ('username', 'active')

class CustomFileView(FileAdmin):
    allowed_extensions = (
        'txt',
        'md',
        'js',
        'css',
        'html',
        'jpg',
        'gif',
        'png'
    )

    editable_extensions = ('md', 'html', 'js', 'css', 'txt')

    def is_accessible(self):
        return current_user.is_authenticated and admin_permission.can()

class ActorView(CustomModelView):
    column_searchable_list = ('first_name', 'last_name', 'hometown')
    column_filters = ('birthday', 'deathday')
    form_extra_fields = {
        "picture": FileField('Picture')
    }

    def on_model_change(self, form, model, is_created):
        path = os.path.abspath(
            os.path.join(
                os.path.dirname(__file__),
                os.pardir
            )
        )
        image_path = os.path.join(path, 'static', 'pictures')
        photo_data = request.files.get(form.picture.name)

        if photo_data:
            name = secure_filename(photo_data.filename)
            model.picture = "/static/pictures/" + name
            photo_data.save(os.path.join(image_path, name))