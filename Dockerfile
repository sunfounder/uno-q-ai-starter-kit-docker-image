FROM ghcr.io/arduino/app-bricks/python-apps-base:0.11.0
USER root

# ALSA config for QCM2290
RUN echo 'pcm.!default { type plug slave.pcm { type hw card 0 device 1 } }' > /etc/asound.conf && \
    echo 'ctl.!default { type hw card 0 device 1 }' >> /etc/asound.conf

# System dependencies from sunfounder_tts
# espeak -> espeak-ng for Debian 12+ compatibility
RUN apt-get update && apt-get install --fix-broken -y && python -c "from urllib.request import urlretrieve; urlretrieve('https://raw.githubusercontent.com/sunfounder/sunfounder_tts/v1/docs/apt-requirements.txt', '/tmp/apt-reqs.txt')" \
    && sed -i 's/\bespeak\b/espeak-ng/' /tmp/apt-reqs.txt \
    && grep -v '^#' /tmp/apt-reqs.txt | grep -vE '^[[:space:]]*$' | xargs -r apt-get install -y --no-install-recommends \
    && rm -rf /var/lib/apt/lists/*

# Install Python libraries from Git
RUN pip install --no-cache-dir \
    git+https://github.com/sunfounder/robot_shield.git@v1 \
    "sunfounder_stt[all] @ git+https://github.com/sunfounder/sunfounder_stt.git@v1" \
    git+https://github.com/sunfounder/sunfounder_tts.git@v1

# Download STT model
RUN mkdir -p /opt/models && \
    python -c "from urllib.request import urlretrieve; urlretrieve('https://huggingface.co/ggerganov/whisper.cpp/resolve/main/ggml-tiny.bin', '/opt/models/ggml-tiny.bin')"

USER 1000
