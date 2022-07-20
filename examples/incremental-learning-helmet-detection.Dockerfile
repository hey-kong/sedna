FROM snowzach/tensorflow-multiarch:2.7.0

RUN sed -i s@/security.ubuntu.com/@/mirrors.aliyun.com/@g /etc/apt/sources.list \
  && sed -i s@/archive.ubuntu.com/@/mirrors.aliyun.com/@g /etc/apt/sources.list \
  && apt-get clean

RUN apt update \
  && apt install -y libgl1-mesa-glx

RUN pip config set global.index-url http://mirrors.aliyun.com/pypi/simple \
  && pip config set install.trusted-host mirrors.aliyun.com \
  && pip install -U pip

COPY ./lib/requirements.txt /home
# install requirements of sedna lib
RUN pip install -r /home/requirements.txt

# extra requirements for example
RUN pip install tqdm==4.62.3
RUN pip install matplotlib==3.5.2
RUN pip install opencv-python==4.5.5.64
RUN pip install Pillow==8.2.0

ENV PYTHONPATH "/home/lib"

WORKDIR /home/work
COPY ./lib /home/lib

RUN apt-get install -y libglib2.0-dev

COPY examples/incremental_learning/helmet_detection/training/  /home/work/


ENTRYPOINT ["python"]
