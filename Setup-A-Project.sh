#!/usr/bin/env bash

# This script can be used to setup a git project on either a local (remote) git server or a GitHub account.
# The methodology presumed is that you will have a development cycle with branches: development, testing, staging, production.
# If you are using a GitHub account, specify the remote path in the format: git@github.com:GitHubUsername/GitHubRepository.git
# Ensure you have uploaded your local SSH Public Key to your GitHub account.

unset name_of_project
unset path_to_project
unset remote_to_project

if [ -z "$name_of_project" ]
    then
        printf "\nPlease specify the name of the project. No spaces. You may use underscores though. \n"
        printf "\nFor example: python_project \n\n"
        read -rep "Project Name: " name_of_project
fi

if [ -z "$path_to_project" ]
    then
        printf "\nPlease specify the project local directory path, without a trailing slash and without the project name. You may use underscores though. \n"
        printf "\nExample 1: /Users/local_computer_username/Projects \n"
        printf "\nExample 2: /home/local_computer_username/Projects \n\n"
        read -rep "Project Path: " path_to_project
fi

if [ -z "$remote_to_project" ]
    then
        printf "\nPlease specify the remote project universal resource indicator. It should start with a user name, include an @host and end in '.git'. \n"
        printf "\nExample 1: username@GitServer:/home/username/Projects/python_project.git \n"
        printf "\nExample 2: git@github.com:GitHubUsername/GitHubRepository.git \n\n"
        read -rep "Remote Path: " remote_to_project
fi

echo " " >&2

mkdir -p "$path_to_project"/"$name_of_project"
git --work-tree="$path_to_project"/"$name_of_project" --git-dir="$path_to_project"/"$name_of_project"/.git init
git --work-tree="$path_to_project"/"$name_of_project" --git-dir="$path_to_project"/"$name_of_project"/.git remote add origin "$remote_to_project"
git --work-tree="$path_to_project"/"$name_of_project" --git-dir="$path_to_project"/"$name_of_project"/.git checkout -b development
touch "$path_to_project"/"$name_of_project"/"$name_of_project"
git --work-tree="$path_to_project"/"$name_of_project" --git-dir="$path_to_project"/"$name_of_project"/.git add .
git --work-tree="$path_to_project"/"$name_of_project" --git-dir="$path_to_project"/"$name_of_project"/.git commit -m "Initial Commit"
git --work-tree="$path_to_project"/"$name_of_project" --git-dir="$path_to_project"/"$name_of_project"/.git push origin development
git --work-tree="$path_to_project"/"$name_of_project" --git-dir="$path_to_project"/"$name_of_project"/.git pull origin development
git --work-tree="$path_to_project"/"$name_of_project" --git-dir="$path_to_project"/"$name_of_project"/.git checkout -b testing
git --work-tree="$path_to_project"/"$name_of_project" --git-dir="$path_to_project"/"$name_of_project"/.git checkout development
git --work-tree="$path_to_project"/"$name_of_project" --git-dir="$path_to_project"/"$name_of_project"/.git push origin development:testing
git --work-tree="$path_to_project"/"$name_of_project" --git-dir="$path_to_project"/"$name_of_project"/.git checkout testing
git --work-tree="$path_to_project"/"$name_of_project" --git-dir="$path_to_project"/"$name_of_project"/.git pull origin testing
git --work-tree="$path_to_project"/"$name_of_project" --git-dir="$path_to_project"/"$name_of_project"/.git checkout -b staging
git --work-tree="$path_to_project"/"$name_of_project" --git-dir="$path_to_project"/"$name_of_project"/.git checkout testing
git --work-tree="$path_to_project"/"$name_of_project" --git-dir="$path_to_project"/"$name_of_project"/.git push origin testing:staging
git --work-tree="$path_to_project"/"$name_of_project" --git-dir="$path_to_project"/"$name_of_project"/.git checkout staging
git --work-tree="$path_to_project"/"$name_of_project" --git-dir="$path_to_project"/"$name_of_project"/.git pull origin staging
git --work-tree="$path_to_project"/"$name_of_project" --git-dir="$path_to_project"/"$name_of_project"/.git checkout -b production
git --work-tree="$path_to_project"/"$name_of_project" --git-dir="$path_to_project"/"$name_of_project"/.git checkout staging
git --work-tree="$path_to_project"/"$name_of_project" --git-dir="$path_to_project"/"$name_of_project"/.git push origin staging:production
git --work-tree="$path_to_project"/"$name_of_project" --git-dir="$path_to_project"/"$name_of_project"/.git checkout production
git --work-tree="$path_to_project"/"$name_of_project" --git-dir="$path_to_project"/"$name_of_project"/.git pull origin production
git --work-tree="$path_to_project"/"$name_of_project" --git-dir="$path_to_project"/"$name_of_project"/.git checkout development

echo " " >&2
echo "Read any and all output above to ensure there were no errors!" >&2
echo " " >&2