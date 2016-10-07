class Config(object):
    SECRET_KEY = 'XMLZODSHE8N6NFOZDPZA2HULWSIYJU45K6N4ZO9M'
    SQLALCHEMY_TRACK_MODIFICATIONS = False


class ProdConfig(Config):
    SQLALCHEMY_DATABASE_URI = 'sqlite:///database.db'
    DEBUG = False


class DevConfig(Config):
    SQLALCHEMY_DATABASE_URI = 'sqlite:///database.db'
    DEBUG = None