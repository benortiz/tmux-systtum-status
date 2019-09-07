#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

source "$CURRENT_DIR/shared.sh"

service_name_option="@systtum-name"
service_status_indicator_success_option="@systtum-indicator-success"
service_status_indicator_running_option="@systtum-indicator-running"
service_status_indicator_failed_option="@systtum-indicator-failed"
systemctl_property="ActiveState"

service_status() {
  local service_name="$(get_tmux_option "$service_name_option")"

  systemctl show --property="$systemctl_property" --user "$service_name" | cut -d= -f2
}

print_status() {
  local status=""
  case $(service_status) in
    "active"|"inactive")
      status="$(get_tmux_option "$service_status_indicator_success_option") "#[fg=white,noitalics]✓""
      ;;
    "activating")
      status="$(get_tmux_option "$service_status_indicator_running_option") "#[fg=white,noitalics]↻""
      ;;
    "failed")
      status="$(get_tmux_option "$service_status_indicator_failed_option") "#[fg=white,noitalics]✖""
      ;;
    *)
      status="hmm"
      ;;
  esac

  echo "$status"
}
print_status
