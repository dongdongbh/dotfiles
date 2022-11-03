#!/usr/bin/env bash
LANGUAGES=$(echo "golang lua cpp typescript python java csharp rust" | tr ' ' '\n')
CORE_UTILS=$(echo "xargs find mv sed awk" | tr ' ' '\n')

SELECTED=$(printf "$LANGUAGES\n$CORE_UTILS" | fzf)
echo $SELECTED
read -p "Query: " QUERY

#if printf LANGUAGES|grep−qsSELECTED; then
if grep -q "$SELECTED" <<< "$LANGUAGES"; then
    curl cht.sh/$SELECTED/$(echo $QUERY | tr ' ' '+')
else
    curl cht.sh/$SELECTED~$(echo $QUERY | tr ' ' '+')
fi
