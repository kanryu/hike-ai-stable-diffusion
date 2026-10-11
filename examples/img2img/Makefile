HIKEC = go run ../../../cmd/hikec
TARGET = windows
OUTPUT = ExamplesImg2Img.exe
MODEL = ../sdxl/Illustrious-XL-v2.0.safetensors
MODEL_URL = https://huggingface.co/OnomaAIResearch/Illustrious-XL-v2.0/resolve/main/Illustrious-XL-v2.0.safetensors?download=true
INPUT = ../sdxl/output.webp
UPSCALE_MODEL = 4x-UltraSharp.pth
UPSCALE_URL = https://huggingface.co/lokCX/4x-Ultrasharp/resolve/main/4x-UltraSharp.pth?download=true
DETECTOR = ../sdxl/face_yolov8m-face.safetensors

.PHONY: all emit-ir build run clean download-model

all: build

emit-ir:
	$(HIKEC) emit-ir -target $(TARGET) -o main.ll main.hike

build: $(MODEL) $(INPUT) $(UPSCALE_MODEL) $(DETECTOR) $(OUTPUT)

$(MODEL):
	curl.exe -L --fail --retry 3 --output "$@" "$(MODEL_URL)"

$(UPSCALE_MODEL):
	curl.exe -L --fail --retry 3 --output "$@" "$(UPSCALE_URL)"

$(OUTPUT): main.hike hike.mod $(MODEL) $(INPUT) $(UPSCALE_MODEL) $(DETECTOR)
	$(HIKEC) build -target $(TARGET) main.hike -o $(OUTPUT)

download-model: $(MODEL)

run: build
	./$(OUTPUT)

clean:
	rm -f main.ll $(OUTPUT) upscaled-4x.webp bicubic-half.webp output.webp *.dll
