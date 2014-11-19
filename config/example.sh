#!/bin/bash -e

export HUBOT_ZOI_API_URL=

if [ "$1" == "slack" ]; then
    export HUBOT_SLACK_TOKEN=
    export HUBOT_SLACK_TEAM=
    export HUBOT_SLACK_BOTNAME=
    export HEROKU_URL=
elif [ "$1" == "irc" ]; then
    export HUBOT_IRC_SERVER=
    export HUBOT_IRC_ROOMS=
    export HUBOT_IRC_NICK=
    export HUBOT_IRC_UNFLOOD=
    export HUBOT_IRC_SEND_NOTICE_MODE="true"
fi
