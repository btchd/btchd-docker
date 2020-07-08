all: build

build:
	docker build -t btchd/btchdd:1.4.1 .

.PHONY: build
