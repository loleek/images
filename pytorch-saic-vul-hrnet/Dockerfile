ARG NUCLIO_LABEL=1.10.2
ARG NUCLIO_ARCH=amd64
ARG NUCLIO_BASE_IMAGE=ubuntu:20.04
ARG NUCLIO_ONBUILD_IMAGE=quay.io/nuclio/handler-builder-python-onbuild:1.10.2-amd64

# Supplies processor uhttpc, used for healthcheck
FROM nuclio/uhttpc:0.0.1-amd64 as uhttpc

# Supplies processor binary, wrapper
FROM ${NUCLIO_ONBUILD_IMAGE} as processor

# From the base image
FROM ${NUCLIO_BASE_IMAGE}

# Copy required objects from the suppliers
COPY --from=processor /home/nuclio/bin/processor /usr/local/bin/processor
COPY --from=processor /home/nuclio/bin/py /opt/nuclio/
COPY --from=uhttpc /home/nuclio/bin/uhttpc /usr/local/bin/uhttpc

# Readiness probe
HEALTHCHECK --interval=1s --timeout=3s CMD /usr/local/bin/uhttpc --url http://127.0.0.1:8082/ready || exit 1

# USER CONTENT
ENV DEBIAN_FRONTEND=noninteractive
COPY sources.list /etc/apt/sources.list
RUN apt-get update && apt-get install software-properties-common -y
RUN add-apt-repository ppa:deadsnakes/ppa
RUN apt-get update && apt-get install -y --no-install-recommends build-essential git curl libglib2.0-0 software-properties-common python3 python3.6-dev python3-pip python3-tk
RUN pip3 install --upgrade pip
RUN pip3 install nuclio-sdk msgpack /opt/nuclio/whl
WORKDIR /opt/nuclio
RUN git clone https://github.com/saic-vul/ritm_interactive_segmentation.git hrnet
WORKDIR /opt/nuclio/hrnet
RUN apt-get install -y --no-install-recommends wget
RUN wget https://github.com/saic-vul/ritm_interactive_segmentation/releases/download/v1.0/coco_lvis_h18_itermask.pth
RUN pip3 install setuptools
RUN pip3 install -r requirements.txt
RUN apt update && apt install -y libgl1-mesa-glx
RUN pip3 uninstall torch torch vision -y
RUN pip3 install torch==1.8.1+cu111 torchvision==0.9.1+cu111 torchaudio==0.8.1 -f https://download.pytorch.org/whl/torch_stable.html
WORKDIR /opt/nuclio

# Run processor with configuration and platform configuration
CMD [ "processor" ]
