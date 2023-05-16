#!/usr/bin/env bash

# Usage: sdf-deploy <project> <commit1> <commit2> <account> <token_id> <token_secret>
#
# Given an SDF Project, a NetSuite Account ID, and two git commit references, determine which
# Objects in the SDF Project have changed between the two commits, update the deploy.xml file
# accordingly, and deploy the Project to the given NetSuite Account using the given token details.
#
echo "export PATH=$PATH:~/project/$1/node_modules/.bin" >> "$BASH_ENV"
if [[ -n $(has-project-changed $1 $2 $3) ]]
then
  cd "$1" || return
  generate-deploy-xml $2 $3
  suitecloud account:savetoken --account $4 --authid $1 --tokenid $5 --tokensecret $6
  npm run sdf-deploy
else
  echo "$1 has not changed; skipping deployment."
fi
