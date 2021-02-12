#!/usr/bin/env bash

path_bioconda_recipes=~/other_projects/bioconda-recipes
read -p "Repository name: " REPOSITORY
read -p "Version number: " version

#Bioconda
# If its the first time you create a recipe first you must clone the bioconda-recipes repo.
# git clone https://github.com/bioconda/bioconda-recipes.git

# Go to your local copy of the bioconda-recipes repo.
cd ${path_bioconda_recipes}

# Make sure you are in the master branch and download the latest changes
git checkout -f master; git pull origin master

# Remove your previous branch local and remote
git branch -D "$REPOSITORY"; git push origin --delete "$REPOSITORY";

# Create a new local branch (Usually the branch is named like your project)
git checkout -b "$REPOSITORY"

# If it not exists create a folder inside recipes for your project
# mkdir  ${path_bioconda_recipes}/recipes/"$REPOSITORY"

############################### IMPORTANT #########################
# Create the recipe files: meta.yaml, build.sh and post-link.sh   #
###################################################################

# If you are creating a project that already is uploaded to Pypi, conda skeleton can be used to create the recipe files
# conda skeleton pypi "$REPOSITORY" --version "$version"
atom ${path_bioconda_recipes}/recipes/"$REPOSITORY"

# Add and push your changes to the new remote branch
git status; git add recipes/$REPOSITORY/*
git commit -m "$message"
git push -u origin $REPOSITORY

# Create a new pull request from your browser
open https://github.com/bioconda/bioconda-recipes/pull/new/$REPOSITORY

# If you are a new user of the bioconda-recipes repo write a comment mentioning @bioconda/core asking them to add as a
# new contributor member.

# Wait for the tests to pass and ask another member of the bioconda-recipes repo to review your changes and merge them.