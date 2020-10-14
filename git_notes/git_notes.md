## git practice

``` shell
# Generate SSH key
ssh-keygen -o
cat ~/.ssh/id_rsa.pub
```



### configuration

* System : /etc/gitconfig

* Global : ~/.gitconfig
    * git config --global user.name "mason"
    * git config --global user.email "xxx@163.com"
    * git config --global color.ui true

* Local : .git/config

    * git config user.name "mason"

git config --list

git reset --hard commitID

### History

git log --abbrev-commit

git log --oneline --graph --decorate

git log f05d8a3...8792d97

git log --since="3 days ago"

git log -- inner_attr.py

git log --follow -- inner_attr.py 

 git show f05d8a

### Renaming and moving files

git mv inner_attr.py attr.py 

git ls-files

git checkout -- deleted_file

git log --all --graph --decorate --oneline

git config --global alias.hist "log --all --graph --decorate --oneline"

git config --global diff.tool BCompare

git config --global difftool.BCompare.path /Applications/Beyond\ Compare.app/Contents/MacOS/BCompare

git config --global difftool.prompt false

git config --global merge.tool BCompare

git config --global mergetool.BCompare.path /Applications/Beyond\ Compare.app/Contents/MacOS/BCompare

git config --global mergetool.prompt false

git config --global --list    

git config --global -e

```shell


masons-MacBook-Pro:Python_exercise mason$ git difftool

git config option diff.tool set to unknown tool: BCompare

Resetting to default...

This message is displayed because 'diff.tool' is not configured.

See 'git difftool --tool-help' or 'git help config' for more details.

'git difftool' will now attempt to use one of the following tools:

opendiff kompare emerge vimdiff

xcode-select: error: tool 'opendiff' requires Xcode, but active developer directory '/Library/Developer/CommandLineTools' is a command line tools instance



git diff 5194c5b HEAD
git difftool 5194c5b HEAD
git diff master origin/master
git difftool master origin/master
```

Solution:

```shell
sudo xcode-select --switch /Applications/Xcode.app/Contents/Developer/
```

### branch

``` 
git branch -a
git branch -m oldbranch newbranch        #change branch name
git branch -d newbranch
git branch -D newbranch
git checkout -b dev_x
git difftool master dev_x
git merge dev_x           # Automatic merge, if conflict happens, add backup file to .gitignore
git merge dev_x --no-ff   # disable fast forward merge



git stash
git stash apply
git stash list
git stash drop



git rebase --abort
git rebase --continue
git pull --rebase origin master
git rebase -i


git stash save "simple changes"
git show stash@{1}
git stash apply stash@{1}
git stash drop stash@{1}
git stash branch newchanges



git cat-file -t 0c96bf
git cat-file -p 0c96bf

git tag --list
git tag -a v-1.0
git push origin v-1.1
git push origin master --tags
.
```

##### p4merge

``` shell
# linux
wget http://www.perforce.com/downloads/perforce/r13.4/bin.linux26x86_64/p4v.tgz
tar zxvf p4v.tgz
sudo cp -r p4v-* /usr/local/p4v/
sudo ln -s /usr/local/p4v/bin/p4merge /usr/local/bin/p4merge

```

##### windows gitconfig

``` shell
[core]
	editor = \"D:\\appinstall\\vscode\\Microsoft VS Code\\Code.exe\" --wait
	autocrlf = true
[user]
	name = Mason
	email = pubuliuyun@163.com
[http]
	proxy = http://127.0.0.1:3213
	sslverify = false

[https]
	proxy = http://127.0.0.1:3213
	sslverify = false
[diff]
	tool = p4merge
[difftool "p4merge"]
	path = D:/appinstall/p4merge/p4merge.exe
[difftool]
	prompt = false

[merge]
	tool = p4merge
[mergetool "p4merge"]
	path = D:/appinstall/p4merge/p4merge.exe
[mergetool]
	keepBackup = false
[difftool "sourcetree"]
	cmd = '' \"$LOCAL\" \"$REMOTE\"
[mergetool "sourcetree"]
	cmd = "'' "
	trustExitCode = true
```

``` shell
vim .bash_profile
alias tp='Typora.exe'
git config --global http.proxy 'socks5://127.0.0.1:1080'
git config --global https.proxy 'socks5://127.0.0.1:1080'
```
Deleting a Remote Branch
``` shell
git push <remote_repo> --delete <remote_branch>
// This was added to Git in v1.7.0, and in Git v2.8.0 they added the ability to use -d instead of the full --delete flag.
Now that the branch is gone from the remote repository, other machines will want to update themselves as well. To do this, they'll want to fetch the update:
$ git fetch --all --prune
The --prune option tells Git to remove all remote-tracking references (i.e. our branch) that no longer exist in the remote repo. Keep in mind, however, that this pruning does not apply to tags. You'll want to use --prune-tags for that.
```
