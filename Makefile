all: build test package clean

build:
	mkdir build
	wget https://github.com/oven-sh/bun/releases/download/bun-v0.3.0/bun-linux-x64-baseline.zip -O ./build/bun-baseline.zip
	unzip ./build/bun-baseline.zip -d ./build
	cp -r ./runtime ./build
	mkdir -p ./build/runtime/opt/bin
	mv ./build/bun*/bun ./build/runtime/opt/bin
	

test: build
	sudo docker build -t test-container:latest .
	sudo docker run -p 9000:8080 -d --name bun-test-lambda test-container:latest
	pytest -qs test_runtime.py
	sudo docker container kill bun-test-lambda
	sudo docker container rm bun-test-lambda

package:
	cd ./build/runtime && zip -r bun-runtime *
	mv ./build/runtime/bun-runtime.zip .

clean:
	rm -rf build
	rm -rf .pytest_cache