FROM ubuntu-debootstrap:14.04
MAINTAINER ReCollect Systems Inc <ops@recollect.net>

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update
RUN apt-get install --yes python python-requests
RUN mkdir /app
WORKDIR /app
COPY *.py requirements.txt /app/

ENTRYPOINT ["/usr/bin/python", "slackbotExercise.py"]
