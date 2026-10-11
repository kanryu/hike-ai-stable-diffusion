HIKEC = go run ../../../cmd/hikec
PYTHON ?= python
TARGET = windows
OUTPUT = ExamplesAnima.exe

DIFFUSION_MODEL = anima-aesthetic-v1.1.safetensors
DIFFUSION_MODEL_URL = https://huggingface.co/circlestone-labs/Anima/resolve/main/split_files/diffusion_models/anima-aesthetic-v1.1.safetensors?download=true
VAE_MODEL = qwen_image_vae.safetensors
VAE_MODEL_URL = https://huggingface.co/circlestone-labs/Anima/resolve/main/split_files/vae/qwen_image_vae.safetensors?download=true
TEXT_ENCODER = qwen_3_06b_base.safetensors
TEXT_ENCODER_URL = https://huggingface.co/circlestone-labs/Anima/resolve/main/split_files/text_encoders/qwen_3_06b_base.safetensors?download=true

.PHONY: all emit-ir build run clean download-models

all: build

emit-ir:
	$(HIKEC) emit-ir -target $(TARGET) -o main.ll main.hike

build: $(DIFFUSION_MODEL) $(VAE_MODEL) $(TEXT_ENCODER) $(OUTPUT)

$(DIFFUSION_MODEL):
	curl.exe -L --fail --retry 3 --output "$@" "$(DIFFUSION_MODEL_URL)"

$(VAE_MODEL):
	curl.exe -L --fail --retry 3 --output "$@" "$(VAE_MODEL_URL)"

$(TEXT_ENCODER):
	curl.exe -L --fail --retry 3 --output "$@" "$(TEXT_ENCODER_URL)"

$(OUTPUT): main.hike hike.mod $(DIFFUSION_MODEL) $(VAE_MODEL) $(TEXT_ENCODER)
	$(HIKEC) build -target $(TARGET) main.hike -o $(OUTPUT)

download-models: $(DIFFUSION_MODEL) $(VAE_MODEL) $(TEXT_ENCODER)

run: build
	./$(OUTPUT)

clean:
	rm -f main.ll $(OUTPUT) output.webp *.dll
