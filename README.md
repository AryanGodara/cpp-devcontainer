# cpp-devcontainer

A reusable C++ development container for Cursor (and VS Code) on macOS. It provides a
consistent Debian 12 Linux toolchain in Docker with IntelliSense, building, debugging,
and an AI coding agent ready out of the box.

## Usage

Requires Docker Desktop. Open the folder in Cursor and run "Dev Containers: Reopen in
Container". The first build takes a few minutes; later opens are fast.

    cmake -S . -B build -G Ninja -DCMAKE_BUILD_TYPE=Debug
    cmake --build build
    ./build/hello

Cmd+Shift+B builds, F5 debugs.

## Included

- Toolchain: g++, clang, clangd, clang-format, clang-tidy, cmake, ninja, lldb
- Editor: clangd (IntelliSense + formatting), CodeLLDB (debugging), CMake Tools. Microsoft
  cpptools is intentionally not used (it is license-blocked in Cursor)
- Agent: Claude Code CLI (auto-updating), plus Node LTS for MCP/npx tooling
- Git: git, git-lfs, GitHub CLI; the host git identity is shared automatically
- Shell: zsh + oh-my-zsh, direnv, fzf, ripgrep, fd, bat, jq, htop, python3

## Notes

The container is Linux, so binaries you build run inside it, not on the host. On Apple
Silicon it runs natively as arm64.
