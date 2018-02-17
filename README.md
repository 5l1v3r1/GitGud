# Git Gud Scrub
A utility to find and clean sensitive information form your git objects. Just simply running "git add" on a file with sensitive information will add it to your index. What's worse is accidentally pushing sensitive information to a public repository. Even if you force push an update to move the remote branch back so the file is no longer in the history, the object still exists and will be pulled down by anyone cloning the repository.

## Usage
To use this utility simply cd into the git repository and curl the script into bash. If you're not a fan of that then copy locally and simply execute it.
