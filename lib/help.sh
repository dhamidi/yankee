subcommand_help() {
  local help_target=${1:-''}
  local summary

  if [[ -n "$help_target" && -n "${_yankee_subcommand_help[$help_target]:-}" ]]; then
    printf "Usage: yankee %s\n\n" "$help_target"
    printf "%s\n" "${_yankee_subcommand_help[$help_target]}"
    return 0
  fi

  printf "Usage: yankee SUBCOMMAND\n"
  printf "\n"
  printf "Available subcommands:\n\n"
  for subcommand in "${!_yankee_subcommand[@]}"; do
    printf "  %-20s" "$subcommand"
    summary=${_yankee_subcommand_summary[$subcommand]:-}
    if [[ -n "$summary" ]]; then
      printf " - %s\n" "$summary"
    else
      printf "\n"
    fi
  done
}

define_subcommand help 'Show this help or help for a subcommand' <<HELP
Without arguments, shows a summary of all available subcommands.

To get help about a specific command, run:

  yankee help COMMAND

for example

  yankee help version
HELP

