# Flux DyPE + SRPO Skin Detailer — ComfyUI Workflow Pack

YouTube walkthrough: https://youtu.be/BUVC-zu8OWk

Two production-tested ComfyUI workflows for realistic image enhancement, micro-detail restoration, and photographic skin detailing — without plastic shine or crunchy artifacts.

- **Flux DyPE + Upscale** — fine surface texture (fabric, hair, stone, metal, microdetail). Best for landscapes, architecture, **work clothes / clothing fabrics**, hair, props, and any AI image that feels too soft.
- **SRPO Skin Detailer + Upscale** — realistic human skin (pores, soft falloff, natural imperfections) without making faces look waxy or over-sharpened.

---

## Get started

If you're enhancing photos of **work clothes / workwear**, go straight to:

→ **[docs/work-clothes-quickstart.md](docs/work-clothes-quickstart.md)**

It walks you through installing the workflow, the models you need, and the exact knobs to turn for fabric detail.

Other docs:

- **[docs/models.md](docs/models.md)** — every model file with download links and where it goes
- **[scripts/install.sh](scripts/install.sh)** — one-shot installer for custom nodes + models (`./scripts/install.sh /path/to/ComfyUI`)
- **[prompts/work-clothes.md](prompts/work-clothes.md)** — prompt snippets for common workwear scenarios

---

## Workflows included

### 1. Flux DyPE + Upscale — Detail Enhancement

File: `Upscale-Recon-Flux-Dype.json`

Enhances microtexture, surface breakup, fine edges, and natural photographic detail. Adds believable enhancement without hallucinating shapes or over-texturing.

Ideal for:
- landscapes
- architecture
- **clothing fabrics (incl. work clothes, uniforms, hi-vis, denim, canvas, leather)**
- hair strands
- props and surfaces
- AI images that feel too soft

Output quality: 2K / 4K / 8K (tile-friendly).

### 2. SRPO Skin Detailer + Upscale — Realistic Skin

File: `SkinDetailer-flux_SRPO_inpaint_example.json`

Enhances pores, micro-breakup, real skin texture, soft falloff, natural imperfections — without plastic, waxy, over-sharpened, or overly smoothed results.

Perfect for portraits, model shots, beauty work, close-ups.

Output quality: 2K / 4K / 8K.

---

## Why two models?

Different models excel at different jobs:

- **Flux DyPE** = best for overall microdetail (and fabric)
- **SRPO** = best for skin textures and facial realism

Using one model for everything gives poor results. Use each in its lane.

---

## How to use

1. Download the JSON workflows from this repo.
2. Drag them directly into ComfyUI.
3. Load your input image.
4. Adjust:
   - denoise strength
   - upscale size
   - prompt (optional)
5. Render.

Both workflows work immediately without extra tuning once the models are in place.

---

## Recommended settings

### Flux DyPE
- Denoise: **0.20–0.35**
- Tile size: **1024–1536**
- Best after a light pre-upscale or SDXL refinement

### SRPO Skin Detailer
- Denoise: **0.10–0.20**
- Avoid over-sharpening
- Use mask control for selective skin detail

---

## Notes for best results

- Don't apply both models to the entire image at once.
- For portraits: SRPO for skin, Flux DyPE for clothing/hair/background.
- Keep sharpening subtle — realism comes from balance, not maximum sharpness.
- Avoid 8x upscales in a single pass. Chain 2x or 4x for stability.

---

## License

Workflows are free for personal and commercial use. Model licenses belong to their respective creators.
