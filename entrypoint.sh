#!/bin/sh -l

echo $(env)

if [ -n "$FLY_PROJECT_PATH" ]; then
  PREV_PATH=$(pwd)
  # Allow user to change directories in which to run Fly commands
  cd "$FLY_PROJECT_PATH" || exit
fi

echo "FLY_APP=$FLY_APP"

if [ -n "$FLY_APP" ]; then
  sh -c "FLY_APP=$FLY_APP flyctl $*"
else
  sh -c "flyctl $*"
fi

ACTUAL_EXIT="$?"

if [ -n "$PREV_PATH" ]; then
  # If we changed directories before, we should go back to where we were.
  cd "$PREV_PATH" || exit
fi

exit $ACTUAL_EXIT
