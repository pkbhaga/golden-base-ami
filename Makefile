#!/usr/bin/env make

PHONY: all
all: install validate build

.PHONY: install
install: install-infra-build-tools install-aws
	pipenv install --dev
	pipenv run ansible-galaxy install -r base-ami/ansible/requirements.yml

.PHONY: install-infra-build-tools
install-infra-build-tools: install-packer install-terraform

.PHONY: install-terraform
install-terraform:
	if [ ! -f /usr/local/bin/terraform ]; then cd /tmp && wget https://releases.hashicorp.com/terraform/0.13.0/terraform_0.13.0_linux_amd64.zip && cd /tmp && unzip terraform_0.13.0_linux_amd64.zip && mv /tmp/terraform /usr/local/bin && rm terraform_0.13.0_linux_amd64.zip; fi;

.PHONY: install-packer
install-packer:
	if [ ! -f /usr/bin/packer ]; then sudo apt-get update && sudo apt-get install -y packer; fi;

.PHONY: install-aws
install-aws:
	if [ ! -f /usr/local/bin/aws ]; then cd /tmp && curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && unzip awscliv2.zip && sudo ./aws/install && rm -rf ./aws/ awscliv2.zip; fi;

