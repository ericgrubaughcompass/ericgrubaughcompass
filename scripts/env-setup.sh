#!/usr/bin/env bash
echo "export PATH=~/project/scripts:$PATH" >> "$BASH_ENV"

# Usage: generate-deploy-xml <commit1> <commit2>
#
# Generate the deploy.xml file of the current SDF Project for changes made between two given commits.
# Assumes the current directory is an SDF Project and that the src/ directory is the project root.
generate-deploy-xml() {
  printf "<deploy>
    <files>
      <path>~/FileCabinet/*</path>
    </files>
    <objects>
      %s
    </objects>
  </deploy>
  " "$(generate-object-paths $1 $2)" > ./src/deploy.xml
}

# Usage: generate-object-paths <commit1> <commit2>
#
# Generates a list of XML path elements containing SDF Objects which have changed between two given
# commits. Assumes the current working directory is the root of an SDF Project.
#
# The resulting list will be usable within the objects element of deploy.xml.
generate-object-paths() {
  git diff --name-only "$1" "$2" -- ./src/Objects  | sed "s/^.*\/src/<path>~/" | sed 's/$/<\/path>/'
}

# has-project-changed <project> <commit1> <commit2>
#
# Determines whether the given SDF project has deployable changes between the two given commits.
# Assumes the given SDF Project resides in the current directory. A "deployable change" is a change
# to any file within the Project's src/ directory.
#
# If the return value is the empty string, the project has no deployable changes.
has-project-changed() {
  git diff --name-only "$2" "$3" -- "./$1/src"
}

# Usage: sdf-deploy <project> <commit1> <commit2> <account> <token_id> <token_secret>
#
# Given an SDF Project, a NetSuite Account ID, and two git commit references, determine which
# Objects in the SDF Project have changed between the two commits, update the deploy.xml file
# accordingly, and deploy the Project to the given NetSuite Account using the given token details.
#
sdf-deploy() {
  echo "export PATH=$PATH:~/project/$1/node_modules/.bin" >> "$BASH_ENV"
  if [[ -n $(has-project-changed $1 $2 $3) ]]
  then
    cd "$1" || return
    generate-deploy-xml $2 $3
    # TODO update-objects
    suitecloud account:savetoken --account $4 --authid $1 --tokenid $5 --tokensecret $6
    npm run sdf-deploy
  else
    echo "$1 has not changed; skipping deployment."
  fi
}
