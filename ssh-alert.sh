#!/usr/bin/env bash

# ipinfo.io token
readonly IPINFO_TOKEN="1**********0"

# Telegram Bot Token
readonly TG_TOKEN="1********0:1******************1"

# Chat ID for alert messages
readonly CHAT_ID="-100**********1"

# Telegram bot send URI
declare -r TG_SEND_URI="https://api.telegram.org/bot$TG_TOKEN/sendMessage"

# Alert function
function ssh_alert_on_auth()
{
    local IP_INFO="$(curl ipinfo.io/$PAM_RHOST?token=$IPINFO_TOKEN)"
    local DATETIME="$(date "+%Y-%m-%d %H:%M:%S")"

    local MESSAGE=$(cat <<TEXT
*${PAM_USER}* loged on *${HOSTNAME}*
at ${DATETIME}
Host: ${PAM_RHOST}
Service: ${PAM_SERVICE}
TTY: ${PAM_TTY}
User info: ${IP_INFO}
TEXT
)

    local TG_PAYLOAD="chat_id=$CHAT_ID&text=$MESSAGE&parse_mode=Markdown&disable_web_page_preview=true"
    curl -s --max-time 10 --retry 3 --retry-delay 2 --retry-max-time 10 -d "$TG_PAYLOAD" $TG_SEND_URI > /dev/null 2>&1 &
}


# Run main function
ssh_alert_on_auth$()
