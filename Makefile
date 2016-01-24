default: build

build:
	docker build -t image-builder-pine-a64 .

sd-image: build
	docker run --rm --privileged -v $(shell pwd):/workspace -v /boot:/boot -v /lib/modules:/lib/modules image-builder-pine-a64

shell: build
	docker run -ti --privileged -v $(shell pwd):/workspace -v /boot:/boot -v /lib/modules:/lib/modules image-builder-pine-a64 bash

testshell: build
	docker run -ti --privileged -v $(shell pwd)/builder:/builder -v $(shell pwd):/workspace -v /boot:/boot -v /lib/modules:/lib/modules image-builder-pine-a64 bash

tag:
	git tag ${TAG}
	git push origin ${TAG}
