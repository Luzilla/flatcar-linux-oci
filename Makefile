CHANNEL?=alpha
ARCH?=amd64
DOWNLOAD?=https://$(CHANNEL).release.flatcar-linux.net/$(ARCH)-usr/current
GITHUB_USER?=till
FLATCAR_USER?=core
SSH_PORT?=2222

ROOT:=flatcar-container.tar.gz
META:=version.txt

REGISTRY?=
IMAGE?=tillk/flatcar-linux
SHELL:=/bin/bash

_name:=flatcar
_context:=rootfs

.PHONY: build
build: rootfs/root.tar build/version.txt
	docker build \
		--build-arg GITHUB_USER=$(GITHUB_USER) \
		-t $(REGISTRY)$(IMAGE):$(VERSION) \
		-t $(REGISTRY)$(IMAGE):$(CHANNEL) \
		-t $(REGISTRY)$(IMAGE):$(CHANNEL)-$(ARCH) \
		$(_context)

rootfs/root.tar:
	wget -O $(_context)/root.tar.gz $(DOWNLOAD)/$(ROOT) && gunzip $(_context)/root.tar.gz

build/version.txt:
	wget -O build/version.txt $(DOWNLOAD)/$(META)

clean:
	rm -f build/version.txt $(_context)/root.tar

.PHONY: dev
dev: build
	@docker run -it \
		--mount type=tmpfs,destination=/run \
		--mount type=tmpfs,destination=/run/lock \
		--mount type=tmpfs,destination=/tmp \
		--volume /sys/fs/cgroup:/sys/fs/cgroup:ro \
		--privileged \
		-p $(SSH_PORT):22 \
		--rm \
		--name $(_name) \
		$(REGISTRY)$(IMAGE):$(CHANNEL)

.PHONY: docker-shell
docker-shell:
	@docker exec --tty -it --user $(FLATCAR_USER) -w /home/$(FLATCAR_USER) $(_name) bash

.PHONY: shell
shell:
	@ssh -o "StrictHostKeyChecking=no" -p $(SSH_PORT) $(FLATCAR_USER)@0.0.0.0
