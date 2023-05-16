#!/usr/bin/env bash
# Usage: generate-deploy-xml <commit1> <commit2>
#
# Generate the deploy.xml file of the current SDF Project for changes made between two given commits
# by performing:
#
# git diff <commit1>..<commit2>
#
# Assumes the current directory is an SDF Project and that the src/ directory is the project root.
printf "
<deploy>
  <files>
    <path>~/FileCabinet/*</path>
  </files>
  <objects>
    %s
  </objects>
</deploy>
" "$(generate-object-paths $1 $2)" > ./src/deploy.xml
