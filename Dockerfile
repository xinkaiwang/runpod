FROM runpod/pytorch:3.10-2.0.0-117 AS runtime
ENV DEBIAN_FRONTEND noninteractive
RUN apt update
RUN apt install -y --no-install-recommends \
    software-properties-common \ 
    git \ 
    openssh-server \ 
    libglib2.0-0 \
    libsm6 \
    libgl1 \
    libxrender1 \
    libxext6 \
    ffmpeg
RUN apt install -y --no-install-recommends  \
    wget \
    curl \
    psmisc \
    rsync \
    vim \ 
    pkg-config \ 
    libcairo2-dev \
    libgoogle-perftools4 \
    libtcmalloc-minimal4 \
    apt-transport-https \
    ca-certificates 
RUN update-ca-certificates

WORKDIR /workspace

RUN git clone https://github.com/comfyanonymous/ComfyUI.git

WORKDIR /workspace/ComfyUI
RUN pip install -r requirements.txt

# WORKDIR /workspace/automatic

# RUN python -m venv /workspace/venv
# ENV PATH="/workspace/venv/bin:$РАТН"
# RUN pip install -U jupyterlab ipywidgets jupyter-archive gdown
# RUN jupyter nbextension enable --py widgetsnbextension
# ADD install.py
# RUN python -m install --skip-torch
# RUN pip install xformers

CMD [ "tail", "-f", "/dev/null" ]
