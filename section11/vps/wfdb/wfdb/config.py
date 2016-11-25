from datetime import timedelta
from celery.schedules import crontab

class Config(object):
    SECRET_KEY = 'XMLZODSHE8N6NFOZDPZA2HULWSIYJU45K6N4ZO9M'
    SQLALCHEMY_TRACK_MODIFICATIONS = False


class ProdConfig(Config):
    SQLALCHEMY_DATABASE_URI = 'sqlite:///database.db'
    DEBUG = False
    CELERY_BROKER_URL = "redis://localhost:6379/0"
    CELERY_BACKEND_URL = "redis://localhost:6379/0"

    CELERYBEAT_SCHEDULE = {
        'echo-every-5-seconds': {
            'task': 'wfdb.tasks.echo',
            'schedule': timedelta(seconds=5),
            'args': ("Hello, World!",)
        },
        'echo-crontab': {
            'task': 'wfdb.tasks.echo',
            'schedule': crontab(day_of_week="0, 1", minute="*/15"),
            'args': ("Hello, World!",)
        },
        'digest-every-sunday': {
            'task': 'wfdb.tasks.digest',
            'schedule': crontab(day_of_week=6, hour=23, minute=30),
        },
    }

class DevConfig(Config):
    SQLALCHEMY_DATABASE_URI = 'sqlite:///database.db'
    DEBUG = True
    CACHE_TYPE = 'null'
    
    ASSETS_DEBUG = True
    CELERY_BROKER_URL = "redis://localhost:6379/0"
    CELERY_BACKEND_URL = "redis://localhost:6379/0"

    CELERYBEAT_SCHEDULE = {
        'echo-every-5-seconds': {
            'task': 'wfdb.tasks.echo',
            'schedule': timedelta(seconds=5),
            'args': ("Hello, World!",)
        },
        'echo-crontab': {
            'task': 'wfdb.tasks.echo',
            'schedule': crontab(day_of_week="0, 1", minute="*/15"),
            'args': ("Hello, World!",)
        },
        'digest-every-sunday': {
            'task': 'wfdb.tasks.digest',
            'schedule': crontab(day_of_week=6, hour=23, minute=30),
        },
    }

class TestConfig(Config):
    SQLALCHEMY_DATABASE_URI = 'sqlite://'
    DEBUG = True
    CACHE_TYPE = 'null'

    WTF_CSRF_ENABLED = False

    CELERY_BROKER_URL = "redis://localhost:6379/0"
    CELERY_BACKEND_URL = "redis://localhost:6379/0"
