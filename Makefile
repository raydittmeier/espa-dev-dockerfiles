
TAG_PREFIX = dev
TAG_VERSION = 0.2.0

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# General targets
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

all: clean

clean: clean.containers clean.images

clean.containers:
	@-./scripts/remove-all-stopped-containers.sh

clean.images:
	@-./scripts/remove-dangling-images.sh

.PHONY: all base clean clean.containers clean.images tools espa centos.tools centos.espa

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Common
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

tools:
	@docker build -t $(TAG_PREFIX).$(SYSTEM).tools \
         -f $(SYSTEM)/tools/Dockerfile .
	@docker tag $(TAG_PREFIX).$(SYSTEM).tools \
        $(TAG_PREFIX).$(SYSTEM).tools:$(TAG_VERSION)

espa:
	@docker build -t $(TAG_PREFIX).$(SYSTEM).espa \
         -f $(SYSTEM)/espa/Dockerfile .
	@docker tag $(TAG_PREFIX).$(SYSTEM).espa \
        $(TAG_PREFIX).$(SYSTEM).espa:$(TAG_VERSION)

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# CentOS
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

centos.tools:
	@SYSTEM=centos make tools

centos.espa: centos.tools
	@SYSTEM=centos make espa

