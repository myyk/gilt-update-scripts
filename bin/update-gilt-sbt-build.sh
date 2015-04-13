#!/bin/bash

VERSION="6.4.0"
BRANCH=$(git branch | sed -n -e 's/^\* \(.*\)/\1/p')

printf "On branch: %s\n" "$BRANCH"

while read -r LINE || [[ -n $LINE ]]; do
  printf "%s\n" "${LINE}"
  cd "/web/${LINE}"
  git checkout master
  git pull
  git checkout -b "upgrade-to-g-s-b-$VERSION"
  sed -i "" -E 's/addSbtPlugin\("com.giltgroupe"[[:space:]]+%[[:space:]]+"gilt-sbt-build"[[:space:]]+%[[:space:]]+"[[:digit:]]+.[[:digit:]]+.[[:digit:]]+"\)/addSbtPlugin("com.giltgroupe" % "gilt-sbt-build" % "'"$VERSION"'")/g' project/build.sbt 
  git commit -a -m "NOJIRA-0: Upgrade gilt-sbt-build tp $VERSION"
  git push origin HEAD:refs/for/$BRANCH
done < projects.txt
