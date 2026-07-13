# UNO Q AI Starter Kit - Python Base Image

Docker base image for SunFounder UNO Q AI Starter Kit Python applications.

## What's Inside

- **Python 3.11** (Debian Bookworm slim)
- **git, build-essential** — source checkout and wheel compilation
- **ALSA utils** — audio device management (amixer, arecord)
- **ALSA config** pre-configured for QCM2290 (48 kHz native)
- **espeak-ng + espeak-ng-espeak** — offline TTS (compatible with `espeak` command)
- **libportaudio2, portaudio19-dev** — PyAudio runtime and build headers
- **robot_shield, sunfounder_stt, sunfounder_tts** — pre-installed Python libraries
- **Whisper tiny model** — bundled STT model

## Usage

```dockerfile
FROM ghcr.io/sunfounder/uno-q-ai-starter-kit-docker-image/uno-q-ai-starter-kit-python-base:latest

# Everything above is already set up — just add your application
```

## Build Locally

```bash
docker build -t uno-q-ai-starter-kit-python-base .
```

## Image Registry

```
ghcr.io/sunfounder/uno-q-ai-starter-kit-docker-image/uno-q-ai-starter-kit-python-base
```

Built and pushed automatically via GitHub Actions on every push to `main` and on version tags (`v*`).
