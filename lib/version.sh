YANKEE_VERSION='0.1.0'

subcommand_version() {
  printf "yankee %s\n" "$YANKEE_VERSION"
}

define_subcommand version 'Display yankee version' <<HELP
Displays the version of yankee.

The format is guaranteed to be "yankee \\d+.\\d+.\\d+", e.g.

  yankee 0.1.0
HELP
