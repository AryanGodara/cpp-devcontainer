FROM mcr.microsoft.com/devcontainers/cpp:1-debian-12

# --- C++ toolchain + senior-dev CLI tooling (installed as root) --------------
# clangd/clang-format/clang-tidy: IntelliSense + formatting/linting for Cursor.
# ninja: fast builds. git-lfs: required by the host ~/.gitconfig LFS filters.
# ripgrep/fd/bat/fzf/jq/tree/htop/direnv: fast search/navigation/DX.
# python3/pip/pipx: scripting + installing Python-based agent tools.
RUN apt-get update \
    && export DEBIAN_FRONTEND=noninteractive \
    && apt-get -y install --no-install-recommends \
        clangd \
        clang-format \
        clang-tidy \
        ninja-build \
        git-lfs \
        ripgrep \
        fd-find \
        bat \
        fzf \
        jq \
        tree \
        htop \
        direnv \
        less \
        unzip \
        ca-certificates \
        python3 \
        python3-pip \
        python3-venv \
        pipx \
    && git lfs install --system \
    && ln -sf "$(command -v fdfind)" /usr/local/bin/fd \
    && ln -sf "$(command -v batcat)" /usr/local/bin/bat \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Pre-create the Claude config dir so the named volume (mounted here at runtime)
# inherits the correct owner/permissions on first creation.
RUN mkdir -p /home/vscode/.claude \
    && chown -R vscode:vscode /home/vscode/.claude \
    && chmod 700 /home/vscode/.claude

# --- Claude Code CLI (installed as the runtime user) -------------------------
# Native install tracks the "latest" release channel and auto-updates in the
# background, so the container always converges to the newest version. The
# auto-updater is intentionally NOT disabled. Manual upgrade: `claude update`.
# Login + config persist across rebuilds via the .claude volume (devcontainer.json).
USER vscode
RUN curl -fsSL https://claude.ai/install.sh | bash
ENV PATH="/home/vscode/.local/bin:${PATH}"
