HIKEC = hikec
TARGET = windows
OUTPUT = ExamplesKrea2.exe

MODEL = krea2_turbo-Q3_K_M.gguf
MODEL_URL = https://huggingface.co/vantagewithai/Krea-2-Turbo-GGUF/resolve/main/krea2_turbo-Q3_K_M.gguf?download=true
VAE_MODEL = wan_2.1_vae.safetensors
VAE_MODEL_URL = https://huggingface.co/Comfy-Org/Wan_2.1_ComfyUI_repackaged/resolve/main/split_files/vae/wan_2.1_vae.safetensors?download=true
TEXT_ENCODER = Qwen3VL-4B-Instruct-Q4_K_M.gguf
TEXT_ENCODER_URL = https://huggingface.co/Qwen/Qwen3-VL-4B-Instruct-GGUF/resolve/main/Qwen3VL-4B-Instruct-Q4_K_M.gguf?download=true
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
