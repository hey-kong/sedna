FROM python:3.7-slim

RUN pip config set global.index-url http://mirrors.aliyun.com/pypi/simple \
  && pip config set install.trusted-host mirrors.aliyun.com \
  && pip install -U pip

RUN mkdir /code
COPY requirements.txt /code
RUN pip install -r /code/requirements.txt
COPY download.py /code
WORKDIR /code

ENV PYTHONUNBUFFERED=1

ENTRYPOINT ["python3", "download.py"]
