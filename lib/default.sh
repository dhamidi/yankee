subcommand_default() {
  local input="$1"
  local cursor="$2"
  local -a words=($input)

  case "${words[0]:-file}" in
    git)  _default_git_branch "$input" "$cursor";;
    ssh)  _default_ssh_host "$input" "$cursor";;
    kill) _default_process_id "$input" "$cursor";;
    *)    _default_file "$input" "$cursor";;
  esac
}

_default_git_branch() {
  local branch=$(git branch | awk '{print $NF}' | fzf)

  subcommand insert " $branch " "$1" "$2"
}

_default_ssh_host() {
  local host=$(awk '$1 == "Host" && $2 !~ /[*]/ { print $2 }' ~/.ssh/config | fzf)

  subcommand insert "$host" "$1" "$2"
}

_default_process_id() {
  local -a pid=($(ps -a -o pid,command | tail -n +2 | fzf))
  subcommand insert "${pid[0]}" "$1" "$2"
}

_default_file() {
  local file=$(fzf)

  subcommand insert "$file" "$1" "$2"
}

define_subcommand default 'The default matcher' <<'HELP'
The default matcher with yankee's builtin rules.

Usually you don't need to invoke this explicitly, but
it can come in handy when needing default behavior in a
custom matcher.
HELP
