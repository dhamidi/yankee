# Inserts TEXT in LINE at POINT.
#
# @stdout $POINT $LINE
subcommand_insert() {
  local text="$1"
  local line="$2"
  local -i point="$3"

  line="${line:0:$point}${text}${line:$point}"
  let point=$((point + ${#text}))
  printf "%d %s\n" "$point" "$line"
}

define_subcommand insert 'helper to insert text in the middle of a line' <<'HELP'
Used in yankee matchers to insert text at a given position,
moving the cursor accordingly.

Example:

  yankee insert "John" " is your name" 0

Outputs:
  
  4 John is your name
HELP
