import os
from flask import Flask, abort
import requests
from time import sleep
import json

app = Flask(__name__)


__version__ = "0.1.0"


def get_version():
    return os.environ["FRONTEND_VERSION"]


def get_backend_host():
    return os.environ["BACKEND_HOST"]


def get_backend_port():
    return os.environ["BACKEND_PORT"]

def inject_delay():
    replyDelay = int(os.environ.get("REPLY_DELAY", 0))
    sleep(replyDelay)


def inject_failure():
    if int(os.environ.get("INJECT_FAILURE", 0)) == 1:
        abort(502)


def inject_settings():
    inject_failure()
    inject_delay()


@app.route("/health")
def get_health():
    inject_settings()
    return "HEALTHY"


@app.route("/")
def backend():
    inject_settings()
    return "Frontend Joker"


@app.route("/joke")
def joke():
    inject_settings()
    jokeObject = requests.get(
        url="http://{0}:{1}/joke/en".format(get_backend_host(), get_backend_port())
    )
    
    jokeDict = json.loads(jokeObject.text)
    return """
    <!DOCTYPE html>
    <head>
      <title> JOKER  </title>
    </head>
    <body style="width: 880px; margin: auto;">
    <h2> Joke </h2>
    <p> {0} </p>
    <p> <i> Joker Backend Version: {1} </i> </p>
    <p> <i> Joker Frontend Version: {2} </i> </p>
    </body>
    """.format(
        jokeDict['Joke'],
        jokeDict['Version'],
        get_version()
    )


def start():
    from waitress import serve

    serve(app, host="0.0.0.0", port=8081)
