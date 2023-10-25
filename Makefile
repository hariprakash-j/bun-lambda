BUN_VERSION = 1.0.7
BUN_LINUX_X86_PACKAGE_NAME = bun-linux-x64-baseline
BUN_BINARY_URL := https://github.com/oven-sh/bun/releases/download/bun-v$(BUN_VERSION)/$(BUN_LINUX_X86_PACKAGE_NAME).zip
AL2_PACKAGE_NAME = bun-v$(BUN_VERSION)-lambda-runtime-x86-al2
TEST_IMAGE_NAME = test-bun-image
TEST_IMAGE_TAG = latest
TEST_CONTAINER_NAME = test-bun-container
TEST_CONTAINER_EXTERNAL_PORT = 9000
TEST_CONTAINER_INTERNAL_PORT = 8080
CONTAINER_RUNTIME = podman

.PHONY: all build test package clean clean-containers

all: package

build: clean
	mkdir build
	wget $(BUN_BINARY_URL) -O ./build/$(BUN_LINUX_X86_PACKAGE_NAME).zip
	unzip ./build/$(BUN_LINUX_X86_PACKAGE_NAME).zip -d ./build
	cp -r ./runtime ./build
	mkdir -p ./build/runtime/bin
	mv ./build/bun*/bun ./build/runtime/bin

test: build clean-containers
	cd ./test_src && yarn install
	$(CONTAINER_RUNTIME) build -t $(TEST_IMAGE_NAME):$(TEST_IMAGE_TAG) .
	$(CONTAINER_RUNTIME) run -p $(TEST_CONTAINER_EXTERNAL_PORT):$(TEST_CONTAINER_INTERNAL_PORT) -d --name $(TEST_CONTAINER_NAME) $(TEST_IMAGE_NAME):$(TEST_IMAGE_TAG)
	pytest -q test_runtime.py
	$(CONTAINER_RUNTIME) container kill $(TEST_CONTAINER_NAME)
	$(CONTAINER_RUNTIME) container rm $(TEST_CONTAINER_NAME)

package: build test
	rm -rf ./package/*.zip
	cd ./build/runtime && zip -r $(AL2_PACKAGE_NAME).zip *
	cd ../../
	mv ./build/runtime/$(AL2_PACKAGE_NAME).zip ./package

clean:
	rm -rf build
	rm -rf .pytest_cache
	rm -rf ./test_src/node_modules
	rm -rf ./__pycache__

clean-containers:
	-$(CONTAINER_RUNTIME) container kill $(TEST_CONTAINER_NAME) 
	-$(CONTAINER_RUNTIME) container rm $(TEST_CONTAINER_NAME) 
