#!/usr/bin/env bash
set -e

# Default installation directory and GitHub repository
DEFAULT_BIN_DIR="/usr/local/bin"
BIN_DIR="${1:-${DEFAULT_BIN_DIR}}"
GITHUB_REPO="intelops/genval"

# Logging helper functions
info() {
    echo "[INFO] $@"
}
fatal() {
    echo "[ERROR] $@" >&2
    exit 1
}

# Determine OS and architecture mapping to GitHub naming conventions
setup_platform() {
    OS=$(uname -s)
    case "$OS" in
        Darwin)
            OS=darwin
            ;;
        Linux)
            OS=linux
            ;;
        *)
            fatal "Unsupported operating system: $OS"
            ;;
    esac

    ARCH=$(uname -m)
    case "$ARCH" in
        x86_64|amd64)
            ARCH=amd64
            ;;
        armv6l|armv7l)
            ARCH=arm
            ;;
        aarch64|arm64)
            ARCH=arm64
            ;;
        *)
            fatal "Unsupported architecture: $ARCH"
            ;;
    esac
}

# Create a temporary directory for downloads and extraction
setup_tmp() {
    TMP_DIR=$(mktemp -d -t genval-install.XXXXXXXXXX)
    trap "rm -rf ${TMP_DIR}" EXIT
}

# Get the latest release version from GitHub
get_latest_release() {
    info "Fetching latest release version from GitHub..."
    LATEST_RELEASE=$(curl -s "https://api.github.com/repos/${GITHUB_REPO}/releases/latest" | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/')
    if [ -z "$LATEST_RELEASE" ]; then
        fatal "Unable to fetch latest release version"
    fi
    info "Latest release version: $LATEST_RELEASE"
}

# Download the binary tarball for the detected OS and architecture
download_binary() {
    DOWNLOAD_URL="https://github.com/${GITHUB_REPO}/releases/download/${LATEST_RELEASE}/genval_${LATEST_RELEASE}_${OS}_${ARCH}.tar.gz"
    info "Downloading binary from ${DOWNLOAD_URL}"
    curl -L -o "${TMP_DIR}/genval.tar.gz" "${DOWNLOAD_URL}" || fatal "Download failed"
}

# Extract the binary from the tarball
extract_binary() {
    info "Extracting binary..."
    tar -xzf "${TMP_DIR}/genval.tar.gz" -C "${TMP_DIR}"
    if [ ! -f "${TMP_DIR}/genval" ]; then
        fatal "genval binary not found after extraction"
    fi
}

# Install the binary into the target directory
install_binary() {
    info "Installing genval to ${BIN_DIR}"
    if [ ! -w "${BIN_DIR}" ]; then
        info "Insufficient permissions for ${BIN_DIR}, using sudo"
        sudo mv "${TMP_DIR}/genval" "${BIN_DIR}/genval" || fatal "Installation failed"
    else
        mv "${TMP_DIR}/genval" "${BIN_DIR}/genval" || fatal "Installation failed"
    fi
    chmod +x "${BIN_DIR}/genval"
    info "Installation complete. genval installed to ${BIN_DIR}/genval"
}

# Main execution
setup_platform
setup_tmp
get_latest_release
download_binary
extract_binary
install_binary
