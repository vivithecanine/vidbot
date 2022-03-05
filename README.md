# vidbot #

This bot aims to be able to take in an arbitrary url via telegram text message, feed it to `yt-dlp`, then embed the video in a response (it may need to figure out what output quality fits under 50mb)

## Development ##

This project uses `poetry` for dependency management, at the time of writing the canonical installation method is:

```curl -sSL https://install.python-poetry.org | python3 -```

After installing poetry, run `poetry install` to generate a venv, your editor should automatically detect it

Create an `.env` file in the root of this repo containing a `TELEGRAM_TOKEN` from https://t.me/botfather to run this project
