# SDXL

最小の Stable Diffusion 画像生成サンプルです。

## 準備

初回の `make build` または `make run` では、Makefile が指定 URL から
フルサイズの統合モデル `Illustrious-XL-v2.0.safetensors` を Hugging Face から
ダウンロードします。同じファイルが
存在する限り、2回目以降は再ダウンロードしません。
このモデルは CLIP と VAE を内包しているため、個別ファイルの指定は不要です。
モデル構成に応じて `main.hike` の `ContextParams` に VAE やテキストエンジンの個別パスを設定できます。

## ビルドと実行

```powershell
go run ../../../cmd/hikec build -target windows main.hike -o ExamplesSDXL.exe
./ExamplesSDXL.exe
```

または Makefile を使用します。

```powershell
make build
make run
```

成功すると `output.webp` が生成されます。WebP は
stable-diffusion.cpp に同梱されている `libwebp.dll` と、配置した
`deps/.../include/encode.h`／`deps/.../lib/libwebp.lib` を使って直接保存します。
顔検出器の元モデル `yolov8m-face.pt` はMakefileが初回だけダウンロードし、
公式変換スクリプトで `face_yolov8m-face.safetensors` へ変換します。ロードに成功した場合は、生成後に顔領域を検出し、
E-Detailerで再描画してからWebPに保存します。検出器をロードできない場合は、
通常生成画像をそのままWebPに保存します。

## この例の範囲

- `ContextParams` からモデルをロード
- 通常の `string` でプロンプトとモデルパスを指定
- `Context.Generate` で画像生成
- `face_yolov8m-face.safetensors` による顔検出と `Adetailer.DetailImage` による顔再描画
- native image buffer を `FreeImages` で解放
- 同梱 `libwebp.dll` で WebP として保存

`make clean` は生成物だけを削除し、統合モデルは残します。

