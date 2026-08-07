#!/bin/sh
printf 'Today is %s (JST).\n' "$(TZ=Asia/Tokyo date '+%Y-%m-%d %a')"
