HIKEC = hikec
TARGET = windows
OUTPUT = ExamplesFlux2.exe

MODEL = flux-2-klein-4b-Q4_K_M.gguf
MODEL_URL = https://huggingface.co/unsloth/FLUX.2-klein-4B-GGUF/resolve/main/flux-2-klein-4b-Q4_K_M.gguf?download=true
VAE_MODEL = flux2-vae.safetensors
VAE_MODEL_URL = https://huggingface.co/Comfy-Org/vae-text-encorder-for-flux-klein-4b/resolve/main/split_files/vae/flux2-vae.safetensors?download=true
TEXT_ENCODER = Qwen3-4B-Q4_K_M.gguf
TEXT_ENCODER_URL = https://huggingface.co/unsloth/Qwen3-4B-GGUF/resolve/main/Qwen3-4B-Q4_K_M.gguf?download=true
MODELS = $(MODEL) $(VAE_MODEL) $(TEXT_ENCODER)

.PHONY: all emit-ir build run clean download-model

all: build

emit-ir:
	$(HIKEC) emit-ir -target $(TARGET) -o main.ll main.hike

build: $(MODELS) $(OUTPUT)

$(MODEL):
	curl.exe -L --fail --retry 3 --output "$@" "$(MODEL_URL)"

$(VAE_MODEL):
	curl.exe -L --fail --retry 3 --output "$@" "$(VAE_MODEL_URL)"

$(TEXT_ENCODER):
	curl.exe -L --fail --retry 3 --output "$@" "$(TEXT_ENCODER_URL)"

$(OUTPUT): main.hike hike.mod $(MODELS)
	$(HIKEC) build -target $(TARGET) main.hike -o $(OUTPUT)

download-model: $(MODELS)

run: build
	./$(OUTPUT)

clean:
	rm -f main.ll $(OUTPUT) output.webp *.dll
