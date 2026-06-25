# Small ComfyUI image for LTX-2.3 MSR workflow

This repo builds a minimal ComfyUI Docker image for the included workflow.

## Required files/models

The workflow expects these models:

- `models/checkpoints/ltx-2.3-22b-distilled-1.1.safetensors`
- `models/text_encoders/gemma_3_12B_it.safetensors`
- `models/loras/LTX-2.3/LTX-2.3-Licon-MSR-V1.safetensors`

The workflow also expects these input images in `ComfyUI/input/`:

- `2.jpg`
- `1.jpg`
- `猪.png`
- `bg (5).png`

If your file names are different, either rename them or update the LoadImage nodes in ComfyUI.

## How to use

1. Upload this repo to GitHub.
2. In the platform page, fill the GitHub repo address.
3. Use image name like `comfyui-ltx23-msr`.
4. Build the image.
5. After starting, open ComfyUI on port `8188` and load the workflow.

## Notes

This image intentionally does not bundle the large model files. Add the models through your platform storage, or modify the Dockerfile to download them during build.
