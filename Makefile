
TAG_PREFIX = dev
TAG_VERSION = 2.13.0

.PHONY: all clean clean.containers clean.images build.tools build.espa build.bridge centos.tools centos.espa centos.bridge tools espa bridge

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# General targets
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

all: clean

clean: clean.containers clean.images

clean.containers:
	@-./scripts/remove-all-stopped-containers.sh

clean.images:
	@-./scripts/remove-dangling-images.sh

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Common
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

build.tools:
	@docker build -t $(TAG_PREFIX)/tools \
         -f $(SYSTEM)/tools/Dockerfile .
	@docker tag $(TAG_PREFIX)/tools \
        $(TAG_PREFIX)/tools:$(TAG_VERSION)

build.espa:
	@docker build -t $(TAG_PREFIX)/espa \
         -f $(SYSTEM)/espa/Dockerfile .
	@docker tag $(TAG_PREFIX)/espa \
        $(TAG_PREFIX)/espa:$(TAG_VERSION)

build.bridge:
	@docker build -t $(TAG_PREFIX)/bridge \
         -f $(SYSTEM)/espa/Dockerfile .
	@docker tag $(TAG_PREFIX)/bridge \
        $(TAG_PREFIX)/bridge:$(TAG_VERSION)

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# CentOS
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

centos.tools:
	@SYSTEM=centos make build.tools

centos.espa:
	@SYSTEM=centos make build.espa

centos.bridge:
	@SYSTEM=centos make build.bridge

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Shortcuts
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

tools: centos.tools
espa: centos.espa
bridge: centos.bridge
