FROM pytorch/pytorch:2.5.1-cuda12.4-cudnn9-runtime

WORKDIR /workspace
ENV DEBIAN_FRONTEND=noninteractive \
    PIP_ROOT_USER_ACTION=ignore

RUN apt-get update && apt-get install -y --no-install-recommends \
    git wget curl ffmpeg libgl1 libglib2.0-0 ca-certificates \
    && rm -rf /var/lib/apt/lists/*

RUN git clone --depth 1 https://github.com/comfyanonymous/ComfyUI.git /workspace/ComfyUI
WORKDIR /workspace/ComfyUI
RUN pip install --upgrade pip && pip install -r requirements.txt

# Custom nodes needed by the workflow
WORKDIR /workspace/ComfyUI/custom_nodes
RUN git clone --depth 1 https://github.com/Lightricks/ComfyUI-LTXVideo.git || true
RUN git clone --depth 1 https://github.com/kijai/ComfyUI-KJNodes.git || true

# Install custom node requirements if present
RUN find /workspace/ComfyUI/custom_nodes -name requirements.txt -print -exec pip install -r {} \;

# Put the workflow into ComfyUI
COPY workflows /workspace/ComfyUI/user/default/workflows

# Optional sample inputs folder. Upload your files here or replace them in ComfyUI.
COPY input /workspace/ComfyUI/input

# Model folders. Put/download models here before running the workflow.
RUN mkdir -p \
    /workspace/ComfyUI/models/checkpoints \
    /workspace/ComfyUI/models/text_encoders \
    /workspace/ComfyUI/models/loras/LTX-2.3

COPY start.sh /workspace/start.sh
RUN chmod +x /workspace/start.sh

EXPOSE 8188
CMD ["/workspace/start.sh"]
