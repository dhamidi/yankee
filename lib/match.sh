subcommand_match() {
  local input=$1
  local cursor=$2
  local -a words=($input)
  local matcher=yankee-match-${words[0]:-default}

  if which "$matcher" 2>/dev/null >/dev/null; then
    $matcher "$input" "$cursor"
  else
    subcommand default "$input" "$cursor"
  fi
}

define_subcommand match 'Match current input and yank accordingly' << 'HELP'
Invokes a matcher for the current command line.

The matcher to invoke is based on the command.  For example,
when invoked with the command line `git checkout`, the yankee will look
for a matcher called `yankee-match-git`.

In case no matcher can be found, the default matcher, `yankee-match-default` is
invoked.
HELP

