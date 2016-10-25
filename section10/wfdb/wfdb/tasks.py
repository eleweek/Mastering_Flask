import datetime
import smtplib
from email.mime.text import MIMEText
from flask import render_template

from wfdb.extensions import celery
from wfdb.models import Post

@celery.task()
def echo(msg):
    return msg


@celery.task()
def multiply(x, y):
    return x * y

@celery.task()
def digest():
    # find the start and end of this week
    year, week = datetime.datetime.now().isocalendar()[0:2]
    date = datetime.date(year, 1, 1)
    if (date.weekday() > 3):
        date = date + datetime.timedelta(7 - date.weekday())
    else:
        date = date - datetime.timedelta(date.weekday())
    delta = datetime.timedelta(days=(week - 1) * 7)
    start, end = date + delta, date + delta + datetime.timedelta(days=6)

    posts = Post.query.filter(
        Post.publish_date >= start,
        Post.publish_date <= end
    ).all()

    if (len(posts) == 0):
        return

    msg = MIMEText(
        render_template("digest.html", posts=posts),
        'html'
    )

    msg['Subject'] = "Weekly Digest"
    msg['From'] = "digest@example.com"

    print(msg.as_string())
    smtp_server = smtplib.SMTP('localhost')
    # smtp_server.starttls()
    # smtp_server.login("user", "password")
    smtp_server.sendmail(
        "digest@example.com",
        ["user@example.com"],
        msg.as_string()
    )
    smtp_server.close()