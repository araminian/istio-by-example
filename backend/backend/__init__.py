from time import sleep
import pyjokes, os
from flask import Flask, abort

app = Flask(__name__)

__version__ = "0.1.0"


def get_version():
    return os.environ["BACKEND_VERSION"]


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
    return "Backend Joker"


@app.route("/joke/en")
def return_EN_Joke():
    inject_settings()

    return {
        "Version": get_version(),
        "Joke": pyjokes.get_joke(language="en", category="all"),
    }


def start():
    from waitress import serve

    serve(app, host="0.0.0.0", port=8080)
