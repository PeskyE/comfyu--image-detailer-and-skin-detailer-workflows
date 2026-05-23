# Quickstart: enhancing photos of work clothes

This guide gets you from zero to a photo-enhanced work-clothes image using the **Flux DyPE** workflow in this repo. It's the right workflow for fabric, stitching, hi-vis material, denim, canvas, leather, and uniform detail.

> If your photo also has a visible face you care about, run Flux DyPE first for the clothing/background, then run the SRPO Skin Detailer workflow on the output for the face. Never apply both models to the whole image at once.

---

## 1. Install ComfyUI

If you don't have it yet, install ComfyUI (desktop app or git clone): https://github.com/comfyanonymous/ComfyUI

Note the path — you'll need it. Common locations:

- macOS / Linux: `~/ComfyUI`
- Windows portable: `C:\ComfyUI_windows_portable\ComfyUI`

---

## 2. Install ComfyUI-Manager (recommended)

Makes installing missing custom nodes one click.

```bash
cd /path/to/ComfyUI/custom_nodes
git clone https://github.com/ltdrdata/ComfyUI-Manager.git
```

Restart ComfyUI.

---

## 3. Install custom nodes + models

The Flux DyPE workflow needs these custom nodes:

- [ComfyUI-DyPE](https://github.com/wildminder/ComfyUI-DyPE) — `DyPE_FLUX` node
- [ComfyUI-KJNodes](https://github.com/kijai/ComfyUI-KJNodes) — `PathchSageAttentionKJ` node
- [rgthree-comfy](https://github.com/rgthree/rgthree-comfy) — `Image Comparer`

And these models (full details in [models.md](models.md)):

| File | Size | Goes in |
|---|---|---|
| `flux1-krea-dev_fp8_scaled.safetensors` | ~12 GB | `models/diffusion_models/` |
| `clip_l.safetensors` | ~250 MB | `models/text_encoders/` |
| `t5xxl_fp8_e4m3fn.safetensors` | ~4.9 GB | `models/text_encoders/` |
| `ae.safetensors` (Flux VAE) | ~335 MB | `models/vae/` |
| `4xFFHQDAT.safetensors` | ~154 MB | `models/upscale_models/` |

### Option A — Automated (recommended)

From this repo:

```bash
./scripts/install.sh /path/to/ComfyUI
```

Flags:
- `SKIP_SRPO=1 ./scripts/install.sh ...` — skip the larger SRPO model if you only care about clothes

### Option B — Manual

1. Open ComfyUI in your browser (default `http://127.0.0.1:8188`).
2. Drag `Upscale-Recon-Flux-Dype.json` onto the canvas.
3. Open **Manager → Install Missing Custom Nodes**.
4. Click each model loader node (UNETLoader, DualCLIPLoader, VAELoader, UpscaleModelLoader) and use **Manager → Model Manager** to download the files listed above.
5. Restart ComfyUI.

---

## 4. Run it on your work-clothes photo

1. In ComfyUI, **drag and drop** `Upscale-Recon-Flux-Dype.json` onto the canvas.
2. **Step 2 — Upload image**: click the `LoadImage` node and pick your photo.
3. **Step 3 — Add prompt**: in the `CLIPTextEncode` node, write a short description of the garment. Examples in [`prompts/work-clothes.md`](../prompts/work-clothes.md). Example:

   ```
   high-resolution photo of a hi-vis safety jacket, reflective tape, dense polyester weave, visible stitching, natural fabric folds, realistic studio lighting
   ```

4. **Step 4 — Denoise**: in the `KSampler` node, set `denoise` to **0.25** for a first pass. Range 0.20–0.35 (lower = more original, higher = more re-detailing).
5. **KSampler** also: `steps: 30`, `sampler: euler`, `scheduler: simple`, `cfg: 1` (defaults are fine).
6. **Upscaler**: leave `4xFFHQDAT` selected, or swap to your favourite from `models/upscale_models/`.
7. Click **Queue Prompt** (top right).

The `Image Comparer (rgthree)` node at the bottom gives you a slider between the original and the enhanced output.

---

## 5. Tuning checklist

If the result looks…

- **too smooth / no new detail** → bump `denoise` up by 0.05 (try 0.30, then 0.35)
- **too plasticky / hallucinated** → drop `denoise` to 0.20
- **wrong colour cast** → set `denoise` to 0.15 and rely more on the upscaler
- **stitching/weave still soft** → try `dype_exponent` 4.0 in the `DyPE_FLUX` node (default 3.0)
- **OOM / out of memory** → switch `t5xxl_fp16` to `t5xxl_fp8_e4m3fn` in the `DualCLIPLoader`; reduce target width/height in `DyPE_FLUX` to 1024×1024

---

## 6. Save your output

The `SaveImage` node is set to `mode: 4` (bypassed) by default in this workflow — switch it to `mode: 0` (active) to write the upscaled image to `ComfyUI/output/UpscaleReconstruction-FluxDype_*.png`.
