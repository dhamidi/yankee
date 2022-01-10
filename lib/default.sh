subcommand_default() {
  local input="$1"
  local cursor="$2"
  local -a words=($input)

  case "${words[0]:-file}" in
    git)   _default_git "$input" "$cursor";;
    cargo) _default_cargo "$input" "$cursor";;
    ssh)   _default_ssh_host "$input" "$cursor";;
    docker|docker-compose) _default_docker_container "$input" "$cursor";;
    man)   _default_man "$input" "$cursor";;
    kill)  _default_process_id "$input" "$cursor";;
    *)     _default_file "$input" "$cursor";;
  esac
}

_default_git() {
  if [[ "${1%% }" == git ]]; then
    _default_git_subcommand "$1" "$2"
  else
    _default_git_branch "$1" "$2"
  fi
}

_default_cargo() {
  if [[ "${1%% }" == cargo ]]; then
    _default_cargo_subcommand "$1" "$2"
  fi
}

_default_cargo_subcommand() {
  local -a cargo_subcommand=()
  cargo_subcommand=(
    $(cargo --list |
        awk 'NR > 1 {print $1}' |
        fzf --preview-window=right:70% --preview='cargo help {}')
  )
 
  if [[ -n "${cargo_subcommand[0]:-}" ]]; then
    subcommand insert " ${cargo_subcommand[0]}" "$1" "$2"
  fi
}

_default_git_subcommand() {
  local -a git_subcommand=($(git help -a |
    sed -ne '/^[[:space:]]/s/^[[:space:]]\+//p' |
    awk '{print $1}' |
    fzf --preview='man git-{}' --preview-window='right:70%'))

  subcommand insert "${git_subcommand[0]:-}" "$1" "$2"
}

_default_git_branch() {
  local branch=$(git branch | awk '{print $NF}' | fzf)

  subcommand insert " $branch " "$1" "$2"
}

_default_man() {
  local manpage=$(whatis -r '.' | fzf)
  local -a words=($manpage)
  subcommand insert " ${words[0]:-}" "$1" "$2"
}

_default_ssh_host() {
  local host=$(awk '$1 == "Host" && $2 !~ /[*]/ { print $2 }' ~/.ssh/config | fzf)

  subcommand insert "$host" "$1" "$2"
}

_default_process_id() {
  local -a pid=($(ps -a -o pid,command | tail -n +2 | fzf))
  subcommand insert "${pid[0]}" "$1" "$2"
}

_default_docker_container() {
  local containers=$(docker ps --format '{{.Names}}')
  if [[ $(wc -l <<<"$containers") -le 1 ]]; then 
    containers=$(docker ps -a --format '{{.Names}}')
  fi
  local container=$(fzf <<<"$containers")

  subcommand insert "${container}" "$1" "$2"
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
