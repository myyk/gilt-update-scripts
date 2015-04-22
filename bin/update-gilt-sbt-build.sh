#!/bin/bash

VERSION="6.5.2"

while read -r LINE || [[ -n $LINE ]]; do
  printf "%s\n" "${LINE}"
  cd "/web/${LINE}"
  git checkout master
  git pull
  git checkout -b "upgrade-g-s-b-to-$VERSION"
  sed -i "" -E 's/addSbtPlugin\("com.giltgroupe"[[:space:]]+%[[:space:]]+"gilt-sbt-build"[[:space:]]+%[[:space:]]+"[[:digit:]]+.[[:digit:]]+.[[:digit:]]+"\)/addSbtPlugin("com.giltgroupe" % "gilt-sbt-build" % "'"$VERSION"'")/g' project/build.sbt 
  git commit -m "NOJIRA-0: Upgrade gilt-sbt-build to $VERSION" project/build.sbt
  git push origin HEAD:refs/for/master
done < projects.txt
