# Git bash


## Branch

### Add new branch
- add new branch

```BASH
git branch new-branch-name
```

- switch to new Branch
```BASH
git checkout new-branch-name
```

- create new branch and switch to it
```BASH
git checkout -b new-branch-name

```

- in new version of git is possible to do next:
```BASH
git switch -c new-branch-name
```


### Move and Rename

Start directory is folder:
```
..folder/
      --/folder_2
      myfile.py
      .git
```

Create new directory inside the folder and move myfile.py there.

```BASH
mkdir new_directory
git mv myfile.py new_directory
```


```
..folder/
      --/new_directory
          myfile.py
      --/folder_2
      .git
```



## Merge

Check current branch:
```bash
git branch
```

Current brunch is new-branch:
```
* new-branch
master
```

Let's switch to master branch:
```bash
git switch master
```


git pull origin master

git merge new-branch



## Remove something from index

```Bash
git rm file-name
```

```Bash
git rm -f file-name
```
