FROM python:3.11

RUN pip install osm_conflate requests

WORKDIR /opt/conflator
