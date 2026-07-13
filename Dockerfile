FROM python:3.11-slim-bookworm

# System dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        git \
        alsa-utils \
        espeak-ng \
        espeak-ng-espeak \
        sox \
        libsox-fmt-mp3 \
        libportaudio2 \
        portaudio19-dev \
        build-essential \
    && rm -rf /var/lib/apt/lists/*

# ALSA config for QCM2290
RUN echo 'pcm.!default { type plug slave.pcm { type hw card 0 device 1 } }' > /etc/asound.conf && \
    echo 'ctl.!default { type hw card 0 device 1 }' >> /etc/asound.conf

# Install Python libraries from Git
RUN pip install --no-cache-dir \
    git+https://github.com/sunfounder/robot_shield.git@v1 \
    "sunfounder_stt[all] @ git+https://github.com/sunfounder/sunfounder_stt.git@v1" \
    git+https://github.com/sunfounder/sunfounder_tts.git@v1

# Download STT model
RUN mkdir -p /opt/models && \
    python -c "from urllib.request import urlretrieve; urlretrieve('https://huggingface.co/ggerganov/whisper.cpp/resolve/main/ggml-tiny.bin', '/opt/models/ggml-tiny.bin')"

USER 1000
