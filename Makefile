.PHONY: help install lint-yaml lint-python format-python check-all

.DEFAULT_GOAL := help

help: ## Show available commands
	@echo "Available targets:"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-20s\033[0m %s\n", $$1, $$2}'

install: ## Install required tools (black, flake8, yamllint)
	@pip install black flake8 yamllint

lint-yaml: ## Lint YAML files
	@yamllint -d "{extends: default, rules: {document-start: disable, line-length: disable, truthy: disable}}" -f parsable .

lint-python: ## Lint Python code with flake8
	@flake8 --max-line-length=99 --ignore=W605,E731,E203 tools/ scripts/

format-python: ## Format Python code with black
	@black --line-length=99 tools/ scripts/

check-all: format-python lint-python lint-yaml ## Run all checks
	@echo "✓ All checks passed!"
