#!/usr/bin/env bash
echo "export PATH=~/project/scripts:$PATH" >> "$BASH_ENV"

c1grep() {
  grep "$@" || test $? = 1;
}

# get-changed-projects <commit1> <commit2>
#
# Determines which SDF projects have changes by performing:
#
# git diff <commit1>..<commit2>
#
# Exports changed projects to $CHANGED_PROJECTS bash variable
get-changed-projects() {
  CHANGED_PROJECTS=$(git diff "$1..$2" --name-only | c1grep -oE "^[A-Za-z0-9_-]+/" | sort -u | sed 's/\///')
  echo "export RECENT_PROJECTS=\"$CHANGED_PROJECTS\"" >> "$BASH_ENV"
  echo "Changed projects: $CHANGED_PROJECTS"
}
