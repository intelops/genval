# Variables
GOTEST=go test
PKGS=./...
TESTFLAGS=-v
GOOS ?= linux
GOARCH ?= amd64

GIT_TAG ?= dirty-tag
GIT_VERSION ?= $(shell git describe --tags --always --dirty)
GIT_HASH ?= $(shell git rev-parse HEAD)
DATE_FMT = +'%Y-%m-%dT%H:%M:%SZ'
SOURCE_DATE_EPOCH ?= $(shell git log -1 --pretty=%ct)
ifdef SOURCE_DATE_EPOCH
    BUILD_DATE ?= $(shell date -u -d "@$(SOURCE_DATE_EPOCH)" "$(DATE_FMT)" 2>/dev/null || date -u -r "$(SOURCE_DATE_EPOCH)" "$(DATE_FMT)" 2>/dev/null || date -u "$(DATE_FMT)")
else
    BUILD_DATE ?= $(shell date "$(DATE_FMT)")
endif
GIT_TREESTATE = "clean"
DIFF = $(shell git diff --quiet >/dev/null 2>&1; if [ $$? -eq 1 ]; then echo "1"; fi)
ifeq ($(DIFF), 1)
    GIT_TREESTATE = "dirty"
endif

SRCS = $(shell find . -iname "*.go")

PKG ?= sigs.k8s.io/release-utils/version
LDFLAGS=-buildid= -X $(PKG).gitVersion=$(GIT_VERSION) \
        -X $(PKG).gitCommit=$(GIT_HASH) \
        -X $(PKG).gitTreeState=$(GIT_TREESTATE) \
        -X $(PKG).buildDate=$(BUILD_DATE)

DIGEST ?=


default: help

help: ## Display this help.
	@awk 'BEGIN {FS = ":.*##";  printf "\nUsage:\n  make \033[36m<target>\033[0m\n"} /^[a-zA-Z_0-9-]+:.*?##/ { split($$2, arr, "|"); printf "  \033[36m%-20s\033[0m %s\n", $$1, arr[1]; for (i=2; i<=length(arr); i++) printf "%*s %s\n", targetWidth+22, " ", arr[i] } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)

test: ## Run full test suite
	@echo "Running tests for all packages..."
	@$(GOTEST) $(TESTFLAGS) $(PKGS)


testfunc: ## Runs test on a specific function specified in the arg.| Example usage `make testfunc validateInput`
	@echo "Running specific test function..."
	@$(GOTEST) $(TESTFLAGS) -run $(filter-out $@,$(MAKECMDGOALS)) $(PKGS)

.PHONY: test testfunc

coverage: ## Generate and view the test coverage
	@go test -coverprofile=coverage.out $(PKGS)
	@go tool cover -html=coverage.out

%:
	@:
format: ## Format the source code
	@echo "Formatting code..."
	@gofmt -s -w .

vet: ## Vet the Go code for potential issues
	@echo "Vetting code for potential issues..."
	@go vet $(PKGS)

lint: ## Run a linter on the codebase using golangci-lint.
	@docker run --rm -v $(shell pwd):/app -w /app golangci/golangci-lint:v1.54.2 golangci-lint run -v


build: ## builds the GenVal app for defined OS/Arch by passing GOOS=$(GOOS) GOARCH=$GOARCH args.| Example usage `make build GOOS=linux GOARCH=amd64`
	@GOOS=$(GOOS) GOARCH=$(GOARCH) CGO_ENABLED=0 go build -trimpath -ldflags "$(LDFLAGS)" -o ./bin/genval .