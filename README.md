# Dotfiles

This is a my dotfiles, I started with a [nicknise](https://github.com/nicknisi/dotfiles) repository fork. 

![capture-demo](https://user-images.githubusercontent.com/25258368/181651042-ea7520e3-deb1-4a0e-858e-0a17f6d2ba5f.png)

## Initial Setup and Installation

### Backup

First, you may want to backup any existing files that exist so this doesn't overwrite your work.

Run `install/backup.sh` to backup all symlinked files to a `~/dotfiles-backup` directory.

This will not delete any of these files, and the install scripts will not overwrite any existing. After the backup is complete, you can delete the files from your home directory to continue installation.

### Installation

If on OSX, you will need to install the XCode CLI tools before continuing. To do so, open a terminal and type

```bash
➜ xcode-select --install
```

Then, clone the dotfiles repository anywhere you like on your machine.

```bash
➜ git clone https://github.com/nicknisi/dotfiles.git
➜ cd dotfiles
➜ ./install.sh
```
