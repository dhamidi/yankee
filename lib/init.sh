subcommand_init() {
  cat <<'BASH'
yankee_yank() {
  local cursor input
  read cursor input < <(yankee match "$READLINE_LINE" "$READLINE_POINT")
  READLINE_LINE="$input"
  READLINE_POINT="$cursor"
}

bind -x '"\C-j":"yankee_yank"'
BASH
}

define_subcommand init 'Output bash source for initializing yankee' <<HELP
HELP
