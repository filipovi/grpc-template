#!make
include .env
export $(shell sed 's/=.*//' .env)

confirm:
	@echo 'Are you sure? [y/N] ' && read ans && [ $${ans:-N} = y ]

build: ## Build the project
	go build -o bin/server

run: build ## Build & Run the project
	./bin/server

protogen: ## Generate ProtoBuf for the Chat
	@protoc --go_out=chat --go_opt=paths=source_relative --go-grpc_out=chat --go-grpc_opt=paths=source_relative chat.proto

.PHONY: help build

HELP_FUNCTION = \
    %help; \
    while(<>) { push @{$$help{$$2 // 'options'}}, [$$1, $$3] if /^([a-zA-Z\-\/]+)\s*:.*\#\#(?:@([a-zA-Z\-]+))?\s(.*)$$/ }; \
    print "usage: make [target]\n\n"; \
    for (sort keys %help) { \
    for (@{$$help{$$_}}) { \
    $$sep = " " x (32 - length $$_->[0]); \
    print "  \033[0;33m$$_->[0]\033[0;37m$$sep\033[0;32m$$_->[1]\033[0;37m\n"; \
    }; \
    print "\n"; }

.DEFAULT_GOAL := help

help: ##@other Show this help.
	@perl -e '$(HELP_FUNCTION)' $(MAKEFILE_LIST)

ERR = $(error found an error!)

err: ; $(ERR)
