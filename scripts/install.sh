#!/usr/bin/env bash
# Installer for the Flux DyPE + SRPO Skin Detailer ComfyUI workflows.
#
# Usage:
#   ./scripts/install.sh /path/to/ComfyUI
#   COMFYUI_DIR=/path/to/ComfyUI ./scripts/install.sh
#
# Flags (env vars):
#   SKIP_SRPO=1      Skip the SRPO diffusion model (~12 GB) if you only want the
#                    Flux DyPE workflow for clothes/fabric.
#   T5_FP16=1        Download t5xxl_fp16 (~9.8 GB) instead of the fp8 variant.

set -euo pipefail

COMFYUI_DIR="${1:-${COMFYUI_DIR:-}}"

if [[ -z "$COMFYUI_DIR" ]]; then
  echo "Usage: $0 /path/to/ComfyUI" >&2
  echo "   or: COMFYUI_DIR=/path/to/ComfyUI $0" >&2
  exit 1
fi

if [[ ! -d "$COMFYUI_DIR" ]]; then
  echo "Error: $COMFYUI_DIR does not exist" >&2
  exit 1
fi

NODES_DIR="$COMFYUI_DIR/custom_nodes"
MODELS_DIR="$COMFYUI_DIR/models"

mkdir -p "$NODES_DIR" \
  "$MODELS_DIR/diffusion_models" \
  "$MODELS_DIR/text_encoders" \
  "$MODELS_DIR/vae" \
  "$MODELS_DIR/loras" \
  "$MODELS_DIR/upscale_models"

clone_or_pull() {
  local repo_url="$1"
  local name
  name="$(basename "$repo_url" .git)"
  local target="$NODES_DIR/$name"
  if [[ -d "$target/.git" ]]; then
    echo "  [keep] $name (already cloned)"
  else
    echo "  [clone] $name"
    git clone --depth 1 "$repo_url" "$target"
  fi
}

download() {
  local url="$1"
  local dest="$2"
  if [[ -f "$dest" ]]; then
    echo "  [skip] $(basename "$dest") (already present)"
    return 0
  fi
  echo "  [pull] $(basename "$dest")"
  if command -v curl >/dev/null 2>&1; then
    curl -L --fail --progress-bar -o "$dest.tmp" "$url"
  elif command -v wget >/dev/null 2>&1; then
    wget --show-progress -O "$dest.tmp" "$url"
  else
    echo "Error: need curl or wget" >&2
    exit 1
  fi
  mv "$dest.tmp" "$dest"
}

echo "==> Installing custom nodes into $NODES_DIR"
clone_or_pull https://github.com/ltdrdata/ComfyUI-Manager.git
clone_or_pull https://github.com/wildminder/ComfyUI-DyPE.git
clone_or_pull https://github.com/kijai/ComfyUI-KJNodes.git
clone_or_pull https://github.com/rgthree/rgthree-comfy.git
clone_or_pull https://github.com/cubiq/ComfyUI_essentials.git
clone_or_pull https://github.com/djbielejeski/a-person-mask-generator.git

echo
echo "==> Downloading models into $MODELS_DIR (this can take a while)"

# Text encoders
download \
  "https://huggingface.co/comfyanonymous/flux_text_encoders/resolve/main/clip_l.safetensors" \
  "$MODELS_DIR/text_encoders/clip_l.safetensors"

if [[ "${T5_FP16:-0}" == "1" ]]; then
  download \
    "https://huggingface.co/comfyanonymous/flux_text_encoders/resolve/main/t5xxl_fp16.safetensors" \
    "$MODELS_DIR/text_encoders/t5xxl_fp16.safetensors"
else
  download \
    "https://huggingface.co/comfyanonymous/flux_text_encoders/resolve/main/t5xxl_fp8_e4m3fn.safetensors" \
    "$MODELS_DIR/text_encoders/t5xxl_fp8_e4m3fn.safetensors"
fi

# VAE
download \
  "https://huggingface.co/Comfy-Org/Lumina_Image_2.0_Repackaged/resolve/main/split_files/vae/ae.safetensors" \
  "$MODELS_DIR/vae/ae.safetensors"

# Flux Krea (for the DyPE / work-clothes workflow)
download \
  "https://huggingface.co/Comfy-Org/FLUX.1-Krea-dev_ComfyUI/resolve/main/split_files/diffusion_models/flux1-krea-dev_fp8_scaled.safetensors" \
  "$MODELS_DIR/diffusion_models/flux1-krea-dev_fp8_scaled.safetensors"

# Flux SRPO (for the skin workflow) — optional, large
if [[ "${SKIP_SRPO:-0}" != "1" ]]; then
  download \
    "https://huggingface.co/rockerBOO/flux.1-dev-SRPO/resolve/3cb809f044916556a9c1c5e336d93c4fd6b509a9/Flux1-Dev-SRPO-v1-fp8.safetensors" \
    "$MODELS_DIR/diffusion_models/Flux1-Dev-SRPO-v1-fp8.safetensors"
else
  echo "  [skip] Flux1-Dev-SRPO-v1-fp8.safetensors (SKIP_SRPO=1)"
fi

# Upscaler
download \
  "https://huggingface.co/Phips/4xFFHQDAT/resolve/main/4xFFHQDAT.safetensors" \
  "$MODELS_DIR/upscale_models/4xFFHQDAT.safetensors"

echo
echo "==> Done."
echo
if [[ "${SKIP_SRPO:-0}" != "1" ]]; then
  echo "Manual step (SRPO workflow only):"
  echo "  The SRPO Skin Detailer also needs Flux_Skin_Detailer.safetensors from CivitAI:"
  echo "    https://civitai.com/models/1018511?modelVersionId=1142009"
  echo "  Save it to: $MODELS_DIR/loras/Flux_Skin_Detailer.safetensors"
  echo
fi
echo "Now restart ComfyUI, drag a workflow JSON onto the canvas, and Queue Prompt."
