subcommand_match() {
  local input=$1
  local cursor=$2
  local -a words=($input)
  case ${words[0]:-file} in
    git) match_git_branch "$input" "$cursor";;
    *) match_file "$input" "$cursor";;
  esac
}

match_git_branch() {
  local branch=$(git branch | awk '{print $NF}' | fzf)
  local -i cursor=$2
  let cursor+=${#branch}

  printf "%d %s%s\n" "$cursor" "$1" "$branch"
}

match_file() {
  local -i cursor=$2
  local file=$(fzf)
  let cursor+=${#file}
  printf "%d %s%s\n" "$cursor" "$1" "$file"
}

define_subcommand match 'Match current input and yank accordingly' << HELP
HELP

