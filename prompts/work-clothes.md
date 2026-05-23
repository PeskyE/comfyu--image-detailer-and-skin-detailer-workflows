# Prompt snippets for work-clothes enhancement

Drop these into the `CLIPTextEncode` node of the Flux DyPE workflow. Describe what's *in the photo* — Flux DyPE adds detail to what's already there, it doesn't invent new garments. Keep prompts short and concrete.

## Generic template

```
high-resolution photo of {garment}, {fabric description}, visible stitching, natural fabric folds, realistic {lighting}, sharp microdetail
```

## Hi-vis / safety wear

```
high-resolution photo of a hi-vis safety jacket, reflective silver tape, dense polyester weave, visible stitching at seams, natural fabric folds, outdoor daylight, sharp microdetail
```

## Workwear / coveralls

```
high-resolution photo of cotton-duck work coveralls, heavy canvas weave, double-stitched seams, brass rivets, slight wear and creasing, realistic workshop lighting
```

## Denim (jeans, jackets)

```
high-resolution photo of indigo selvedge denim, visible warp and weft, chain-stitch hem, copper rivets, natural fade and whiskering, soft daylight
```

## Leather (boots, jackets, gloves)

```
high-resolution photo of full-grain leather, natural pore texture, visible stitching, subtle creasing and patina, warm directional lighting
```

## Uniforms (medical, kitchen, hospitality)

```
high-resolution photo of a crisp cotton-poly uniform shirt, fine twill weave, pressed collar and cuffs, button placket, neutral studio lighting
```

## Knitwear / wool

```
high-resolution photo of a wool knit sweater, visible cable knit texture, natural fibre fuzz, soft falloff, warm interior lighting
```

## Tips

- Don't include negative things you *don't* want ("no blur", "not plastic") — Flux mostly ignores those.
- Lighting words (`daylight`, `studio`, `overcast`, `workshop`) help DyPE preserve the original mood.
- If the photo includes a person, **don't** describe skin here — that's the SRPO workflow's job. Keep this prompt about the garment.
