#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

source "$CURRENT_DIR/scripts/shared.sh"

status_interpolation_string="\#{systtum_status}"
status_script="#($CURRENT_DIR/scripts/systtum_status.sh)"

update_tmux_option() {
  local option="$1"
  local option_value="$(get_tmux_option "$option")"
  # replace interpolation string with a script to execute
  local new_option_value="${option_value/$status_interpolation_string/$status_script}"
  set_tmux_option "$option" "$new_option_value"
}

main() {
  # Put "#{systtum_status}" interpolation in status-right or
  # status-left tmux option to get current tmux continuum status.
  update_tmux_option "status-right"
  update_tmux_option "status-left"
}

main
