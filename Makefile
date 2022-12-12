all: build clean

build:
	mkdir build
	wget https://github.com/oven-sh/bun/releases/download/bun-v0.3.0/bun-linux-x64-baseline.zip -O ./build/bun-baseline.zip
	unzip ./build/bun-baseline.zip -d ./build
	cp -r ./runtime ./build
	mkdir -p ./build/runtime/opt/bin
	mv ./build/bun*/bun ./build/runtime/opt/bin
	cd ./build/runtime && zip -r bun-runtime *

clean:
	rm -rf build