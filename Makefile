include config.mk

.DEFAULT_GOAL := help

.PHONY: install
install: ## Install Zig
     curl -O https://ziglang.org/builds/zig-linux-$(ZIG_VERSION).tar.xz
     tar -xvf zig-linux-$(ZIG_VERSION).tar.xz
     mkdir -p $(HOME)/.local/share/zig
     mv zig-linux-$(ZIG_VERSION)/* $(HOME)/.local/share/zig/
     rm -rf ./zig-linux-$(ZIG_VERSION)
     rm ./zig-linux-$(ZIG_VERSION).tar.xz

.PHONY: help
help: ## Help
     @grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sed 's/Makefile://' | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
