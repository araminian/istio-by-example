FROM python:3.8.13-slim-bullseye
RUN useradd -ms /bin/bash -d /app -u 1000 joker
WORKDIR /app
COPY --chown=joker:joker poetry.lock pyproject.toml ./
RUN pip install poetry && \
    poetry export --without-hashes -f requirements.txt --output requirements.txt && \
    pip install -r requirements.txt
COPY --chown=joker:joker backend ./backend
RUN poetry config virtualenvs.create false && \
    poetry install --no-dev
USER joker
CMD [ "jokerbackend" ]