#!/bin/sh

regex=$1

set -e

cd "$(git rev-parse --git-dir)"

# Find all the objects that are in packs:

packed=$(find objects/pack -name 'pack-*.idx' | while read p ; do git show-index < $p | cut -f 2 -d ' '; done)

# And now find all loose objects:

loose=$(find objects/ | egrep '[0-9a-f]{38}' | grep -v /pack/ | perl -pe 's:^.*([0-9a-f][0-9a-f])/([0-9a-f]{38}):\1\2:';)

# Deduplicate the packed and loose hashes
all=$(echo "$packed\n$loose" | sort | uniq)

# Itterate over all hashes
for hash in $all
do
  # Check if it is a blob (a raw file)
  type=$(git cat-file -t $hash)
  if [ "$type" == "blob" ]
  then
    # If it is a blob, get the contents and check against the regex
    content=$(git cat-file -p $hash)
    if [[ "$content" =~ $regex ]]
    then
      echo "$hash"
      echo "$content"
    fi
  fi
done
