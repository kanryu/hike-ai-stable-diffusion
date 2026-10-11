# img2img

`../sdxl/output.webp`を入力にする後処理パイプラインの検証サンプルです。

1. StableDiffusion.cppネイティブのESRGAN UltraSharp PTHアップスケーラーで4倍拡大
2. SDパッケージのネイティブbicubicフィルターで縦横1/2に縮小（元画像の2倍）
3. 同じSDXLモデルとプロンプトで、顔検出付きADetailerを実行
4. `output.webp`へ保存

中間画像として`upscaled-4x.webp`と`bicubic-half.webp`も保存します。
UltraSharpのPTHファイルは初回の`make run`で取得され、`make clean`では削除されません。

```powershell
make run
```

SDXLモデルと顔検出モデルは`../sdxl`のサンプルと共有します。
`make clean`は実行ファイル、IR、生成画像を削除しますが、モデルファイルは残します。
