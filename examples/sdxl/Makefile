HIKEC = go run ../../../cmd/hikec
PYTHON ?= python
TARGET = windows
OUTPUT = ExamplesSDXL.exe
MODEL = Illustrious-XL-v2.0.safetensors
MODEL_URL = https://huggingface.co/OnomaAIResearch/Illustrious-XL-v2.0/resolve/main/Illustrious-XL-v2.0.safetensors?download=true
DETECTOR_SOURCE = yolov8m-face.pt
DETECTOR_SOURCE_URL = https://huggingface.co/deepghs/yolo-face/resolve/main/yolov8m-face/model.pt?download=true
DETECTOR = face_yolov8m-face.safetensors
CONVERT_SCRIPT = ../../tools/convert_yolov8_to_safetensors.py

.PHONY: all emit-ir build run clean download-model download-detector convert-detector

all: build

emit-ir:
	$(HIKEC) emit-ir -target $(TARGET) -o main.ll main.hike

build: $(MODEL) $(DETECTOR) $(OUTPUT)

$(MODEL):
	curl.exe -L --fail --retry 3 --output "$(MODEL)" "$(MODEL_URL)"

$(DETECTOR_SOURCE):
	curl.exe -L --fail --retry 3 --output "$(DETECTOR_SOURCE)" "$(DETECTOR_SOURCE_URL)"

$(DETECTOR): $(DETECTOR_SOURCE) $(CONVERT_SCRIPT)
	$(PYTHON) $(CONVERT_SCRIPT) $(DETECTOR_SOURCE) $(DETECTOR)

$(OUTPUT): main.hike hike.mod $(MODEL) $(DETECTOR)
	$(HIKEC) build -target $(TARGET) main.hike -o $(OUTPUT)

download-model: $(MODEL)

download-detector: $(DETECTOR)

convert-detector: $(DETECTOR)

run: build
	./$(OUTPUT)

clean:
	rm -f main.ll $(OUTPUT) output.ppm output.webp *.dll

