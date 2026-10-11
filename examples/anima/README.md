# Anima

Animaの最小画像生成サンプルです。

Animaは、統合モデルではなく次の3つのファイルを個別に指定します。

- 拡散モデル: `anima-aesthetic-v1.1.safetensors`
- VAE: `qwen_image_vae.safetensors`
- テキストエンジン: `qwen_3_06b_base.safetensors`

## ビルドと実行

初回だけモデルをダウンロードします。

```powershell
make build
make run
```

または、モデルを先に取得します。

```powershell
make download-models
```

生成に成功すると`output.webp`が作成されます。`make clean`は実行ファイル、LLVM IR、出力画像、コピーされたDLLだけを削除し、3つのモデルファイルは残します。

## Hike側での指定

このサンプルは自然文ベースのプロンプトを使い、1024×1344で生成します。

```hike
params.DiffusionModelPath = "anima-aesthetic-v1.1.safetensors"
params.VAEPath = "qwen_image_vae.safetensors"
params.LLMPath = "qwen_3_06b_base.safetensors"
```
