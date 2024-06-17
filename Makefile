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
	if [ -f $(HOME)/.bashrc ]; then echo 'export PATH=$(HOME)/.local/share/zig:$$PATH' >> $(HOME)/.bashrc; fi
	if [ -f $(HOME)/.zshrc ]; then echo 'export PATH=$(HOME)/.local/share/zig:$$PATH' >> $(HOME)/.zshrc; fi
	@echo "Zig has been installed. Please restart your terminal or run 'source ~/.bashrc' or 'source ~/.zshrc' to update your PATH."

.PHONY: uninstall
uninstall: ## Uninstall Zig
	rm -rf $(HOME)/.local/share/zig
	if [ -f $(HOME)/.bashrc ]; then sed -i '/export PATH=$(HOME)\/.local\/share\/zig:$$PATH/d' $(HOME)/.bashrc; fi
	if [ -f $(HOME)/.zshrc ]; then sed -i '/export PATH=$(HOME)\/.local\/share\/zig:$$PATH/d' $(HOME)/.zshrc; fi
	@echo "Zig has been uninstalled. Please restart your terminal or run 'source ~/.bashrc' or 'source ~/.zshrc' to update your PATH."

.PHONY: help
help: ## Help
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sed 's/Makefile://' | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
