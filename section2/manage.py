#!/usr/bin/env python

from flask.ext.script import Manager
from app import app, db 

manager = Manager(app)


@manager.shell
def make_shell_context():
    """ Creates a python REPL with several default imports
        in the context of the app
    """

    return dict(app=app, db=db)


if __name__ == "__main__":
    manager.run()
