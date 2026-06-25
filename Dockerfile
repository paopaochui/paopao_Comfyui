FROM pytorch/pytorch:2.4.1-cuda12.1-cudnn9-runtime

WORKDIR /workspace

RUN apt-get update && apt-get install -y \
    git \
    wget \
    curl \
    libgl1 \
    libglib2.0-0 \
    && rm -rf /var/lib/apt/lists/*

RUN git clone https://github.com/comfyanonymous/ComfyUI.git

WORKDIR /workspace/ComfyUI

RUN pip install --upgrade pip
RUN pip install -r requirements.txt

# 复制你的工作流
COPY workflows /workspace/ComfyUI/user/default/workflows

# 复制启动脚本
COPY start.sh /workspace/start.sh
RUN chmod +x /workspace/start.sh

EXPOSE 6006

CMD ["/workspace/start.sh"]
