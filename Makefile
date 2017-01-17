
TAG_PREFIX = dev
TAG_VERSION = 2.12.0

.PHONY: all clean clean.containers clean.images build.tools build.espa centos.tools centos.espa tools espa

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
	@docker build -t $(TAG_PREFIX).$(SYSTEM).tools \
         -f $(SYSTEM)/tools/Dockerfile .
	@docker tag $(TAG_PREFIX).$(SYSTEM).tools \
        $(TAG_PREFIX).$(SYSTEM).tools:$(TAG_VERSION)

build.espa:
	@docker build -t $(TAG_PREFIX).$(SYSTEM).espa \
         -f $(SYSTEM)/espa/Dockerfile .
	@docker tag $(TAG_PREFIX).$(SYSTEM).espa \
        $(TAG_PREFIX).$(SYSTEM).espa:$(TAG_VERSION)

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# CentOS
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

centos.tools:
	@SYSTEM=centos make build.tools

centos.espa:
	@SYSTEM=centos make build.espa

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Shortcuts
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

tools: centos.tools
espa: centos.espa
