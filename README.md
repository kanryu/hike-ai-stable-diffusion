# Hike AI Stable Diffusion

`github.com/kanryu/hike-ai-stable-diffusion` provides a Hike binding for the
stable-diffusion.cpp C API. The current native bundle is the Windows shared
runtime under `deps/stable-diffusion.cpp-master-948-228c707-windows`.

## Import

```hike
import "github.com/kanryu/hike-ai-stable-diffusion/sd"
import _ "github.com/kanryu/hike-ai-stable-diffusion/shared"
```

## Minimal image generation

```hike
params := sd.ContextParams{}
sd.InitContextParams(&params)
params.ModelPath = "models/sd15.safetensors"

ctx := sd.NewContext(&params)
if ctx == nil { return 1 }
defer ctx.Close()

request := sd.ImageGenParams{}
sd.InitImageGenParams(&request)
request.Prompt = "a watercolor mountain landscape"
request.Width = 512
request.Height = 512
request.SampleParams.SampleSteps = 20
request.BatchCount = 1

images, count, ok := ctx.Generate(&request)
if ok { defer sd.FreeImages(images, count) }
```

The returned images are raw RGB/RGBA buffers owned by the native library. Use
`Image.Width`, `Image.Height`, `Image.Channel`, and `Image.Data` to pass them to
an image encoder such as `hike-images-vips`.

All path and option text fields in the public parameter structures are ordinary
Hike `string` values. The binding creates the temporary native C-string view
internally for `NewContext` and `Context.Generate`; callers do not need to use
`cstring(...)` or maintain native string buffers.

## Upscaling

```hike
upscaler := sd.NewUpscaler("models/esrgan.safetensors", false, 0, 0, "", "")
if upscaler != nil {
    defer upscaler.Close()
    images, count, ok := upscaler.Upscale(input, 2)
    if ok { defer sd.FreeImages(images, count) }
}
```

`UpscalerModelScale` reads the scale metadata without loading an upscaler
context. `Upscaler.Factor` returns the factor of a loaded context.

## ADetailer

```hike
detector := sd.NewAdetailer("models/face_yolo.onnx", 0, "", "")
if detector != nil {
    defer detector.Close()
    detail := sd.AdetailerParams{Prompt: "detailed face"}
    images, count, ok := detector.DetailImage(ctx, input, detail, &request)
    if ok { defer sd.FreeImages(images, count) }
}
```

## Native dependency

Importing `shared` links `stable-diffusion.lib` on Windows and copies every DLL
from the bundled `bin` directory beside the generated executable. The module
metadata is intentionally kept separate from the `sd` package so the module
can later be moved to its own repository without changing the public import
layout.

The bundled stable-diffusion.cpp and ggml components retain their upstream
licenses. See `deps/stable-diffusion.cpp-master-948-228c707-windows/LICENSE`.

