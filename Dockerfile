FROM runpod/pytorch:3.10-2.0.0-117 AS runtime

ENV DEBIAN_FRONTEND=noninteractive

# Update and install necessary packages
RUN apt update && apt install -y --no-install-recommends \
    software-properties-common \
    git \
    openssh-server \
    libglib2.0-0 \
    libsm6 \
    libgl1 \
    libxrender1 \
    libxext6 \
    ffmpeg \
    wget \
    curl \
    psmisc \
    rsync \
    vim \
    pkg-config \
    libcairo2-dev \
    apt-transport-https \
    ca-certificates && \
    update-ca-certificates && \
    rm -rf /var/lib/apt/lists/*

# Set up SSH server with public key authentication
RUN mkdir /var/run/sshd && \
    mkdir -p /root/.ssh && \
    chmod 700 /root/.ssh

# Copy the public key into the image (Replace 'id_rsa.pub' with your public key file)
COPY authorized_keys /root/.ssh/authorized_keys

# Set permissions on the authorized_keys file
RUN chmod 600 /root/.ssh/authorized_keys && \
    chown root:root /root/.ssh/authorized_keys && \
    sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config && \
    sed -i 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' /etc/pam.d/sshd && \
    echo "PasswordAuthentication no" >> /etc/ssh/sshd_config && \
    echo "PubkeyAuthentication yes" >> /etc/ssh/sshd_config && \
    echo "export VISIBLE=now" >> /etc/profile

# Expose SSH port
EXPOSE 22

# Set working directory
WORKDIR /workspace

# Clone your repository
RUN git clone https://github.com/comfyanonymous/ComfyUI.git

WORKDIR /workspace/ComfyUI
RUN pip install -r requirements.txt

# Keep the container running
CMD ["/usr/sbin/sshd", "-D"]
