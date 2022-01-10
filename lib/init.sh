YANKEE_KEY=${YANKEE_KEY:-'\C-j'}

subcommand_init() {
  cat <<'BASH'  | sed -e "s!__YANKEE_KEY__!$YANKEE_KEY!"
yankee_yank() {
  local cursor input
  read cursor input < <(yankee match "$READLINE_LINE" "$READLINE_POINT")
  READLINE_LINE="$input"
  READLINE_POINT="$cursor"
}

bind -x '"__YANKEE_KEY__":"yankee_yank"'
BASH
}

define_subcommand init 'Output bash source for initializing yankee' <<HELP
HELP
