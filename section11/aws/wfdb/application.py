#!/usr/bin/env python

from wfdb import create_app

application = create_app('wfdb.config.ProdConfig')