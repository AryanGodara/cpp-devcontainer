#!/usr/bin/env bash
# Runs once after the container is created. Wires up shell DX and prints a
# verification report of the installed toolchain.
set -uo pipefail

echo "==> Wiring shell integrations (direnv, fzf)"
for rc in "$HOME/.bashrc" "$HOME/.zshrc"; do
    [ -f "$rc" ] || touch "$rc"
    case "$rc" in
        *.zshrc) shell=zsh ;;
        *)       shell=bash ;;
    esac

    # direnv: auto-load per-directory .envrc files
    if ! grep -q 'direnv hook' "$rc"; then
        echo "eval \"\$(direnv hook ${shell})\"" >>"$rc"
    fi

    # fzf: key-bindings + completion (Debian ships these under /usr/share/doc/fzf)
    kb="/usr/share/doc/fzf/examples/key-bindings.${shell}"
    cp="/usr/share/doc/fzf/examples/completion.${shell}"
    [ -f "$kb" ] && ! grep -q "$kb" "$rc" && echo "source $kb" >>"$rc"
    [ -f "$cp" ] && ! grep -q "$cp" "$rc" && echo "source $cp" >>"$rc"
done

echo ""
echo "==> Toolchain verification"
report() {
    local name="$1"
    shift
    if command -v "$name" >/dev/null 2>&1; then
        printf '  [ok]   %-12s %s\n' "$name" "$("$@" 2>&1 | head -1)"
    else
        printf '  [MISS] %-12s not found\n' "$name"
    fi
}

report g++ g++ --version
report clang++ clang++ --version
report clangd clangd --version
report clang-format clang-format --version
report cmake cmake --version
report ninja ninja --version
report lldb lldb --version
report git git --version
report git-lfs git-lfs version
report gh gh --version
report node node --version
report npm npm --version
report python3 python3 --version
report rg rg --version
report fd fd --version
report bat bat --version
report fzf fzf --version
report jq jq --version
report direnv direnv --version
report claude claude --version

echo ""
echo "==> Mounts"
printf '  ~/Developer  -> %s\n' "$( [ -d "$HOME/Developer" ] && echo present || echo MISSING )"
printf '  ~/.claude    -> %s\n' "$( [ -d "$HOME/.claude" ] && echo present || echo MISSING )"

echo ""
echo "==> Done. Run 'claude' to log in (first time), or 'claude update' to upgrade."
