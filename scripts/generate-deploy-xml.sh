#!/usr/bin/env bash
printf "
<deploy>
  <files>
    <path>~/FileCabinet/*</path>
  </files>
  <objects>
    $(generate-object-paths)
  </objects>
</deploy>
" > src/deploy.xml

