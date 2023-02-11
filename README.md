dotfiles

inspired by the article by mitxela

https://mitxela.com/projects/dotfiles_management

Provides a simple mechanism for tracking all of your linux configuration files like ~/.bashrc with git.

dotfiles creates a git repo and allows you to add in files from anywhere in your directory tree.

# install dotfiles

```bash
dart pub global activate dotfiles

dotfiles init
```


# add files to your dot file repo

dotfiles add <path to file>

# commit files added or changed files
dotfiles commit

# list of tracked dotfiles

dotfile list

# run any git command against your dotfile repo

dotfile <any git command>

# push dotfiles to remote repo

dotfiles simply creates a local git repo.

If you want to backup your dotfiles git repo we suggest creating a remote
repo on the liks of git hub.

Details of pushing a local repository to github can be found [here](https://docs.github.com/en/get-started/importing-your-projects-to-github/importing-source-code-to-github/adding-locally-hosted-code-to-github).