#!/usr/bin/env bash
echo "export PATH=~/project/scripts:$PATH" >> "$BASH_ENV"

c1grep() {
  grep "$@" || test $? = 1;
}

# Usage: generate-object-paths <commit1> <commit2>
#
# Generates a list of XML path elements containing SDF Objects which have changed between two given
# commits by performing:
#
# git diff <commit1>..<commit2>
#
# The resulting list will be usable within the objects element of deploy.xml.
generate-object-paths() {
  git diff --name-only "$1" "$2" -- ./src/Objects  | sed "s/^.*\/src/<path>~/" | sed 's/$/<\/path>/'
}

# get-changed-projects <commit1> <commit2>
#
# Determines which SDF projects have changes by performing:
#
# git diff <commit1>..<commit2>
#
# Exports changed projects to $CHANGED_PROJECTS bash variable
get-changed-projects() {
  CHANGED_PROJECTS=$(git diff --name-only "$1" "$2" | c1grep -oE "^[[:alnum:]-]+/" | sort -u | sed 's/\///')
  echo "export RECENT_PROJECTS=\"$CHANGED_PROJECTS\"" >> "$BASH_ENV"
  echo "Changed projects: $CHANGED_PROJECTS"
}

# has-project-changed <project> <commit1> <commit2>
#
# Determines whether the given SDF project has changed between the two given commits by performing:
#
# git diff <commit1>..<commit2>
#
# Returns the project name if the project has changed; otherwise returns empty string
has-project-changed() {
  git diff --name-only "$2" "$3" | c1grep -oE "^$1/" | sort -u | sed 's/\///'
}
