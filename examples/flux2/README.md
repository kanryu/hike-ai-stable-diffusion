# Flux.2 Klein 4B

SDXLサンプルをベースにしたFlux.2 Klein 4Bの画像生成サンプルです。
SDXLとは別のモデル構成を使用します。

## モデルファイルの準備

指定のHugging Face URLから、拡散モデル `flux-2-klein-4b-Q4_K_M.gguf` を取得します。
このGGUFはstable-diffusion.cppでは拡散モデルとして読み込み、VAEとテキストエンコーダーも
明示して指定します。テキストエンコーダーには、約2.5 GBの量子化GGUF
`Qwen3-4B-Q4_K_M.gguf` を使用します。元の約8.0 GBのSafetensorsよりダウンロード量を
抑えられます。最初の `make build` または `make download-model` 時に3ファイルを取得し、
同名ファイルがあれば再取得しません。

## ビルドと実行

```powershell
hikec build -target windows main.hike -o ExamplesFlux2.exe
./ExamplesFlux2.exe
```

またはMakefileを使用します。

```powershell
make build
make run
```

生成画像は `output.webp` に保存されます。
