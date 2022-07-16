FROM python:3.8.13-slim-bullseye
WORKDIR /app
COPY . .
RUN pip install poetry
EXPOSE 8080
RUN poetry config virtualenvs.create false && poetry install --no-dev
CMD [ "jokerbackend" ]