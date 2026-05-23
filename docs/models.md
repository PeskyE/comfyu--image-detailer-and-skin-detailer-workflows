# Model checklist

Everything you need for the two workflows in this repo, with direct download links and the exact ComfyUI subdirectory.

## Folder layout

```
ComfyUI/
└── models/
    ├── diffusion_models/
    │   ├── flux1-krea-dev_fp8_scaled.safetensors      # Flux DyPE workflow
    │   └── Flux1-Dev-SRPO-v1-fp8.safetensors          # SRPO Skin Detailer workflow
    ├── text_encoders/
    │   ├── clip_l.safetensors                         # both workflows
    │   └── t5xxl_fp8_e4m3fn.safetensors               # both workflows (fp16 also OK if you have VRAM)
    ├── vae/
    │   └── ae.safetensors                             # both workflows (Flux VAE)
    ├── loras/
    │   └── Flux_Skin_Detailer.safetensors             # SRPO only
    └── upscale_models/
        └── 4xFFHQDAT.safetensors                      # both workflows
```

## Downloads

### Diffusion models

- **flux1-krea-dev_fp8_scaled.safetensors** (~12 GB) — used by `Upscale-Recon-Flux-Dype.json`
  - https://huggingface.co/Comfy-Org/FLUX.1-Krea-dev_ComfyUI/resolve/main/split_files/diffusion_models/flux1-krea-dev_fp8_scaled.safetensors

- **Flux1-Dev-SRPO-v1-fp8.safetensors** (~12 GB) — used by `SkinDetailer-flux_SRPO_inpaint_example.json`
  - https://huggingface.co/rockerBOO/flux.1-dev-SRPO/resolve/3cb809f044916556a9c1c5e336d93c4fd6b509a9/Flux1-Dev-SRPO-v1-fp8.safetensors

### Text encoders (CLIP + T5)

- **clip_l.safetensors** (~246 MB)
  - https://huggingface.co/comfyanonymous/flux_text_encoders/resolve/main/clip_l.safetensors

- **t5xxl_fp8_e4m3fn.safetensors** (~4.9 GB) — recommended (lower VRAM)
  - https://huggingface.co/comfyanonymous/flux_text_encoders/resolve/main/t5xxl_fp8_e4m3fn.safetensors

- (Optional, higher quality, ~9.8 GB) **t5xxl_fp16.safetensors**
  - https://huggingface.co/comfyanonymous/flux_text_encoders/resolve/main/t5xxl_fp16.safetensors

### VAE

- **ae.safetensors** (~335 MB) — the Flux VAE
  - https://huggingface.co/Comfy-Org/Lumina_Image_2.0_Repackaged/resolve/main/split_files/vae/ae.safetensors

### LoRA (SRPO workflow only)

- **Flux_Skin_Detailer.safetensors** (~600 MB) — requires a CivitAI account / API key
  - https://civitai.com/models/1018511?modelVersionId=1142009
  - The installer prints a reminder for this one; download it manually and drop it into `models/loras/`.

### Upscaler

- **4xFFHQDAT.safetensors** (~154 MB) — 4x DAT upscaler trained on FFHQ
  - https://huggingface.co/Phips/4xFFHQDAT/resolve/main/4xFFHQDAT.safetensors

## Required custom nodes

Install via [ComfyUI-Manager](https://github.com/ltdrdata/ComfyUI-Manager) or `git clone` into `ComfyUI/custom_nodes/`.

| Workflow | Custom node | Repo |
|---|---|---|
| Flux DyPE | ComfyUI-DyPE | https://github.com/wildminder/ComfyUI-DyPE |
| Flux DyPE | ComfyUI-KJNodes (`PathchSageAttentionKJ`) | https://github.com/kijai/ComfyUI-KJNodes |
| Flux DyPE + SRPO | rgthree-comfy (`Image Comparer`, `Power Lora Loader`) | https://github.com/rgthree/rgthree-comfy |
| SRPO | ComfyUI_essentials (`MaskPreview+`) | https://github.com/cubiq/ComfyUI_essentials |
| SRPO | a-person-mask-generator | https://github.com/djbielejeski/a-person-mask-generator |
