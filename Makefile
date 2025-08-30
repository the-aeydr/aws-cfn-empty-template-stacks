# Sane defaults
SHELL := /bin/bash
.ONESHELL:
.SHELLFLAGS := -eu -o pipefail -c
.DELETE_ON_ERROR:
MAKEFLAGS += --warn-undefined-variables
MAKEFLAGS += --no-builtin-rules

SELF_DIR := $(dir $(lastword $(MAKEFILE_LIST)))

.DEFAULT_GOAL: _DEFAULT
.PHONY: _DEFAULT
_DEFAULT: ; @echo -n ""
# ---------------------- Includes ---------------------------
ifdef GLOBAL_MAKEFILE_LIBRARY
  include $(wildcard $(GLOBAL_MAKEFILE_LIBRARY)/*.mk)
endif

# ---------------------- COMMANDS ---------------------------
# Default params
STACK_NAME ?= aws-cfn-empty-template-stacks
PARAMETERS ?= 

.PHONY: cfn-init
cfn-init: # Initialize a CloudFormation Stack with no resources 
	@aws cloudformation deploy \
		--template-file cloudformation/empty/stack.template.yaml \
		--stack-name $(STACK_NAME)

.PHONY: cfn-describe
cfn-describe: # Describe the CloudFormation stack
	@aws cloudformation describe-stacks \
		--no-cli-pager \
		--stack-name $(STACK_NAME) \
		--output table

.PHONY: cfn-destroy
cfn-destroy: # Teardown the CloudFormation stack 
	@aws cloudformation delete-stack \
		--stack-name $(STACK_NAME)
