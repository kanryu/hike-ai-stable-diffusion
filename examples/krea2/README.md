# Krea2 Turbo

Krea2 Turbo画像生成用のstable-diffusion.cppサンプルです。Flux.2 Kleinのサンプルとは
独立しており、両方のモデルを引き続き使用できます。

## モデルファイルの準備

このサンプルは次の3ファイルを使用します。

- 拡散モデル: `krea2_turbo-Q3_K_M.gguf`（約6.0 GB）
- VAE: `wan_2.1_vae.safetensors`（約254 MB）
- Qwen3-VLテキストエンコーダー: `Qwen3VL-4B-Instruct-Q4_K_M.gguf`（約2.5 GB）

最初の `make build` または `make download-model` でHugging Faceから取得します。
ダウンロード済みファイルは再取得しません。モデルファイルの利用前に各配布元の
ライセンスを確認してください。

## ビルドと実行

```powershell
make build
make run
```

または個別にビルドできます。

```powershell
hikec build -target windows main.hike -o ExamplesKrea2.exe
./ExamplesKrea2.exe
```

生成画像は `output.webp` に保存されます。
