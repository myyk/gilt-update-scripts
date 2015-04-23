#!/bin/bash

VERSION="0.13.8"

while read -r LINE || [[ -n $LINE ]]; do
  printf "%s\n" "${LINE}"
  cd "/web/${LINE}"
  git checkout master
  git pull
  git checkout -b "upgrade-sbt-to-$VERSION"
  sed -i "" -E 's/sbt.version[[:space:]]*=[[:space:]]*[[:digit:]]+.[[:digit:]]+.[[:digit:]]+/sbt.version='"$VERSION"'/g' project/*.properties 
  git commit -m "NOJIRA-0: Upgrade sbt to $VERSION" project/*.properties
  git push origin HEAD:refs/for/master
done < projects.txt
