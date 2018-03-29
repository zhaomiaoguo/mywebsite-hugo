#!/bin/bash

echo -e "\033[0;32mDeploying updates to GitHub...\033[0m"

# delete public folder
rm -rf public

# Build the project.
hugo # if using a theme, replace by `hugo -t <yourtheme>`

# Go To Public folder
cd ..

cd chengjun.github.io

# ssh-add ~/.ssh/id_rsa
# git remote set-url origin git@github.com:chengjun/chengjun.github.io.git

# rm -rf en
# rm -rf zh
# rm -rf note
# rm -rf post

# cp -av
cp -av /Users/datalab/github/mywebsite-hugo/public/* .

# Add changes to git.
git add -A

# Commit changes.
msg="rebuilding site `date`"
if [ $# -eq 1 ]
  then msg="$1"
fi
git commit -m "$msg"

# Push source and build repos.
git push origin master

# Come Back
cd ..

cd mywebsite-hugo
