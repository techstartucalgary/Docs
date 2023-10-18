# Tech Start's Git Guide<!-- omit from toc -->

![alt_text](images/image4.png "Git Logo")

## Contents<!-- omit from toc -->

- [Getting Started - Setting up a Repository](#getting-started---setting-up-a-repository)
- [Git Analogy](#git-analogy)
- [GUI vs Command Line?](#gui-vs-command-line)
- [Staging Files \& Creating Commits](#staging-files--creating-commits)
- [Common Commands](#common-commands)
- [Branches](#branches)
- [Remote Repositories](#remote-repositories)
- [Merge Conflicts](#merge-conflicts)
- [Using GitHub](#using-github)
- [Our recommended Git workflow](#our-recommended-git-workflow)
- [Big Picture Git/GitHub Workflow](#big-picture-gitgithub-workflow)
- [FAQ](#faq)
- [Advanced Section](#advanced-section)
- [Git Stash](#git-stash)
- [Git Clean](#git-clean)
- [Undoing Commits \& Changes](#undoing-commits--changes)
- [Git Rebase and Git Merge](#git-rebase-and-git-merge)

## Note<!-- omit from toc -->

Unless otherwise stated, all git commands are one line terminal commands

We are also assuming that you have set up a project at `/path/to/project` and had `cd`'ed to `/path/to/project`

## Getting Started - Setting up a Repository

[GitHub: Create a Repository](https://docs.github.com/en/repositories/creating-and-managing-repositories)

A Git Repository is virtual storage of your code, allowing you to save versions of your code, as well as share and allow others to edit the code.

Initializing a new repository: `git init`

- This step is typically used by the project manager, or the owner of the project

Cloning an existing repository: `git clone [GitHub git link]`

E.g. `git clone https://github.com/techstartucalgary/tsu-website.git`

- This step is typically used by the project members, or anyones who wants to add onto the projects after it has already been created
- The GitHub git link can be located on the GitHub repository website under the `<> Code` dropdown

## Git Analogy

Imagine that we have two people working on the same paper remotely, Person A and Person B. Person B is the laziest of the two, so Person A starts the paper.

Person A choses to create a word document on their local machine. This can be seen as **Initializing a new repository.**

After working on the paper for a bit, they realize that Person B also needs to contribute, so they send the paper by email to Person B. This step is equivalent to **forking a repository.**

Person B decides that they would prefer to work on the paper by hand, and so they takes the email that Person A sent, and prints it to work on, **cloning the repository**

## GUI vs Command Line?

There are a number of great GUI (graphical user interface) tools that simplify the process of
using Git, like GitHub Desktop, GitKraken, and the built-in Source Control tab in VSCode.
There's nothing wrong with using these tools, but we like to encourage our members to use the
command line in order to get a better understanding of what exactly you're doing. It's also universal,
so whatever you learn here can be used in any organization that uses Git!

## Staging Files & Creating Commits

Git works using units of change called **_`commits`_**. These commits are essentially snapshots of your project. To share any changes, additions, and deletions that you make with other people and upload it to the internet, you will need to package them into a commit first.

You can think of the staging area of git (the green box that says "staged changes" in the below diagram) like a box. You can add and remove changes from the box on a _per-file_ basis.

Committing is like sealing that box and sticking a label on it. The contents of that box are your changes. But, if there are changes in the untracked or unstaged areas, they will not be included in the commit, because they are outside of the box.

The following diagram shows how the staging process works, and what commands you can use to move changes (again, per-file basis) between areas. Use the `git status` command to see a summary of where every change in your project is on this diagram! We recommend using `git status` frequently.

![image](images/image2.png)

## Common Commands

Here are some common commands for using Git to store and prepare the code to be pushed to the remote repository.
They are shown in the general order that you want to use them in.

Below is the legend for some common, optional parameters which are shown

- **(-text)** = optional parameters for command, which are **called as is** (`git command -text`)
- **\<helloWorld>** = optional parameters for command, which are **called with your version of the name** (`git command helloWorld`)
- For example: For `git add [path]`, you should replace `[path]` with `path/to/your/file`, so the final command is `git add path/to/your/file`

### `git status`

Shows the status of all changes (all staged or unstaged changes, not committed changes). It shows where every change is on the diagram above, and even lists some helpful commands.

It will also say what branch you are on, and if you are ahead or behind the remote version of your branch in terms of commits (more on this in later sections).

Additionally, if you have a merge conflict, it will show which files caused it.

### `git add [path/to/file]`

>`git add app/pages/HomePage.tsx`

Selects the specified files, moves it to the “staging area” to be included in the next commit.

This command will also allow adding a deleted file to be staged, which after being committed and pushed will remove the file from the git branch.

**This command will ignore all files in the “.gitignore” file**.

- `[path/to/file]` File path expression. Any files which match the expression are acted upon by `git add`
  - You can use `git add -p` to add parts of a changed file if needed.
  - Pro tip: You can use `git add -A` to add all changed files! Read about why [you shouldn't always do this](https://github.com/git-guides/git-add#git-add-all-files).

### `git commit -m "[commitMessage]"`

>`git commit -m "Updated homepage text"`

Creates a new commit that includes **all** changes that you added to the staging area.

You always need to include a commit message (`-m`) for your commit . It is helpful to be as descriptive as possible!

If you don't use the `-m` flag and provide a commit message in quotations, Git will make you write a commit message using a text editor. However, this can be very confusing since your default Git text editor is often configured to be VIM (stuck in VIM? type `:qa` to exit). For this reason, we recommend always specifying the commit message using `-m`.  

After you commit, these changes are no longer in the staging area - they are in your commit!

- (`-m`) means you will be specifying a commit message in quotations

- `"[commitMessage]"` the message that will be attached to the commit. Only usable if `-m` is used, otherwise a text editor will appear for the commit message.
- Tip: always wrap your message in double quotes (`"`). This lets you use abbrevations in your message (`... -m "Reverted Ben's Changes"`)

### `git restore [path/to/file]`

>`git restore app/pages/HomePage.tsx`

Discards local changes in a file, thereby restoring its last committed state.

Think of it like a super-undo, allowing you to quickly get rid of accidental or unnecessary changes, restoring your files to how they used to be before you changed them.

It won't work if your file is already staged - you'll have to unstage it with `git restore --staged [path/to/file]` first.

### `git restore --staged [path/to/file]`

>`git restore --staged app/pages/HomePage.tsx`

Removes the file from the Staging Area, but preserve all modifications you made to it.
You can use it if you accidentally added a file to the staging area whose changes shouldn't be included as part of the next commit you are planning to make.
If the file was originally untracked, it becomes untracked again. If it was originally a file with unstaged changes, the changes become unstaged again.

### Naming commits

When you create a commit, you always want to include a descriptive name for the commit that describes exactly what it accomplishes. You wouldn’t label a moving box with kitchen items as simply “stuff”.
Remember that other people will see these commit names, so make it easy for them to understand!

For a video tutorial on staging files, watch [this](https://www.youtube.com/watch?v=KngvG8WzYLU&ab_channel=TheNetNinja)

If you want to learn about additional flags and commands you can use in the process of staging files and adding commits, see the section [Advanced Staging & Commits](#advanced-staging-and-commits)

## Branches

Branches represent an independent copy of the code that has _branched_ off the main code at a certain time.
They allow new features to be worked on, while ensuring that a working version of the code is not tampered with.
This allows large changes to be made to the code base, with little fear of breaking your projects.

### `git branch`

Lists all branches in the current repository

### `git branch [branchName]`

>`git branch ben/updateFont`

Creates a branch called `branchName` in the current repository.

The created branch's commit history will match the branch you were on when you called `git branch`.

We recommend naming branches according to what you want your branch to do, prefixed by your name.
For example, if I was updating the font on a website, I might call my branch `ben/updateFont`.
Since branch names include whitespace, we recommend using camelCase to name them, but check with your PM
how they want to handle this.

### `git branch -d [branchName]`

>`git branch -d ben/updateFont`

Deletes the branch called `branchName`

Note: you **cannot** delete the branch you are one! `git checkout` to another branch first.

(You can use `-D` instead of `-d` to force delete the specified branch, even is it has unmerged changes.
It's typically better to use `-d`, unless you are 100% sure you will never need the branch you are deleting again)

### `git checkout [branchName]`

Navigates your current directory to the specified branch, allows you to select which line of development you are working on.

You can only switch branches if you have no unstaged/staged changes in your current branch. If you can't switch branches because of this, see [What happens if you can't checkout?](#what-happens-if-you-cant-checkout) for more instructions.

Pro tip: You can use `git checkout -b [branchName]` to create a branch and switch to it immediately.

### How to use branches

Some rules (more like guidelines):

- Every single time you start modifying the code you should create a new branch to use
- Branches should generally only be for one feature
- Always branch off `main`

Before you make your branch, you should make sure you are creating your branch based on the most recent code. Do `git checkout main` to switch to the primary branch of your repository. You should also do `git pull` to make sure the primary branch is up to date with the version present on your remote repository (more on this in the next section).

Now that you are on the primary branch, use `git branch [branchName]` to create a new branch based on the current one. Make sure you name it according to what you aim to accomplish there (see the description of the command above).

Now that you have created your branch, you'll want to switch to it. Use `git checkout [branchName]` to switch to your branch. You can do work here and follow the instructions in the staging files and creating commits section to save your changes into commits.

Eventually, you'll be done using the branch (perhaps you will follow the instructions in the next few sections to push it to your remote repository and use it in a pull request. or perhaps you need to work somewhere else). Either way, you can switch to a different branch with `git checkout [branchName]`

If you have completed a pull request for your branch to merge it into a different branch of your project, you no longer need to keep the local copy of your branch. We recommend you use `git branch -d` to delete any branches you will no longer need to use. This makes sure your local repository remains nice and tidy.

Here's a quick summary of the commands:

```bash
git checkout main
git pull
git branch ben/updateFont
git checkout ben/updateFont
... doing stuff ...
git checkout main
git branch -d ben/updateFont
```

![Git Branch Diagram](images/branchDiagram.png)

#### What happens if you can't checkout?

Git will not let you checkout to switch branches if you have staged or unstaged changes.

You will have a few choices on what to do:

- Restore files to how they originally were (either by manually undoing, or ideally making use of `git restore`, described in the previous section). Do this if any of your changes are unnecessary or accidental.
- Create a commit, following instructions from the previous section. **Only create a commit if you actually want to save the changes you made**.
  - We recommend you _avoid making commits on any branches that you share with other people_, especially your primary branch (`main`)! All Tech Start repositories actually prohibit commits to `main` to prevent this.
- Utilize `git stash` to move changes from one branch to another without needing to commit them. Do this if your changes are intentional, but you wanted them on a different branch than the one you are currently on. This is described in more detail [here.](#git-stash)

You can combine these approaches to deal with your changes as necessary.

## Remote Repositories

When you work with Git, you will typically have a **_local repository_** (the copy of your project that exists on your personal device) and a **_remote repository_** (the copy of your project that exists on the internet, usually on a service like GitHub, GitLab or BitBucket)

An absolutely core part of using Git is managing the interactions between your local repository and the associated remote repository. The two key commands you will need to learn are `git push` (which you can use to _push_ commits from your local repository to the remote repository)
and `git pull` (which you can use to _pull_ commits from the remote repository and insert them into your own local repository).

A common mistake that newcomers to Git will make is assuming that the local repository is the same as the remote repository - when they're actually 2 separate concepts. Your commits won't appear on the remote repository until you manually push them there. If someone else pushes new changes to the remote repository, you won't see their changes on your local repository until you manually pull those changes to your device.

Most version control related work happens in a local repository(staging, committing, viewing status, etc.).
Remote repositories come into play when you start working with others on the same project.
You can think of it as a cloud file server that you use to collaborate with others.

![Remotes](images/image5.png)

| Local                                                                                               | Remote                                                                                                                  |
| --------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------- |
| Are located on the computers of the team members                                                    | Are on the internet or a local network                                                                                  |
| Contains branches, commits, tags                                                                    | Contains branches, commits, tags                                                                                        |
| All “coding work” happens only in the local repository, and needs to be made and committed locally. | After the work has been committed locally, it can be “uploaded” to the remote repository in order to share with others. |

Note: You can name a local branch the same name as the remote branch, but they are NOT the same

Note: You can also have multiple remote repositories (default is `origin`), though you probably won't need this,
since each local repository stores what it's remote is.

`git fetch` is what you do when you want to see what everybody else has been working on. It doesn’t force you to actually merge the changes into your repository. This makes fetching a safe way to review commits before integrating them with your local repository.

You might be wondering how to set a remote, and the good news is that if you cloned your repository from GitHub,
it's been set for you, so no need to worry!
If you need to change the remote for some reason, you can do `git remote set-url origin <url>`

[Intro to Remote Repositories](https://www.git-tower.com/learn/git/ebook/en/command-line/remote-repositories/introduction/)

### `git pull [remoteName] [branchName]`

`git pull origin ben/updateFont`

Pulls all changes/commits from the specified remote branch, and inserts them into your current branch.

Pro tip: Use `git pull` without any other options to update the branch you're on. You'll most likely only use this to update `main`.

More technical description: fetches from the remote branch (`git fetch`), and merges your current branch with commits from the remote (`git merge`)

- `[remoteName] [branchName]` pulls from a specific branch, which you specify

`git pull origin main`

Fetches commits from the master branch of the origin remote (into the local origin/master branch), and then it merges origin/master into the branch you currently have selected

### `git push`

Updates the remote branch with your staged, local commits

**Always `pull` before `push`ing to a branch to avoid unwanted merge conflicts and errors**..

## Merge Conflicts

Conflicts generally arise when two people have changed the same lines in a file, or if one developer deleted a file while another developer was modifying it. In these cases, Git doesn't know which change is correct. Git will mark the file as being conflicted and halt the merging process. It is then the developers' responsibility to resolve the conflict.

Although they look scary, resolving merge conflicts is a completely normal part of working collaboratively.

The general steps for resolving merge conflicts can be seen as:

1. Figure out the conflicts and change them accordingly
2. Re-commit the changes
3. Attempt to merge with the selected branches
4. Read error messages (if any) and repeat if necessary

Some useful commands for attempting to fix merge conflicts

| Command             | Description                                                                                   |
| ------------------- | --------------------------------------------------------------------------------------------- |
| `git status`        | Help identify conflicted files                                                                |
| `git log --merge`   | Produces a log with a list of commits that conflict between the merging branches              |
| `git diff`          | Finds the differences between the states of a repository, which helps in preventing conflicts |
| `git reset --mixed` | Undo changes to the working directory and staging area                                        |

### Example of Merge Conflicts shown in Command Line<!-- omit from toc -->

![alt_text](images/image1.png "image_tooltip")

In this case, there are two instances of the file “merge.text” that were modified by different branches/people. Git is unable to determine which lines to keep, as both were changed manually.

### Resolving Merge Conflicts

1. Identify Conflicted Files

Git will notify you if there are any merge conflicts after running `git status`. You can identify these conflicts by looking at your project files. Conflicted files will have markers like `<<<<<<< HEAD`, `=======`, and `>>>>>>> [branch name]` where the conflicting changes are.

2. Open the Conflicted File

Use a text editor or an integrated development environment (IDE) like VS Code to open the conflicted file. Inside, you will see the conflicting sections clearly marked by symbols.

3. Resolve Conflicts

Review the conflicting sections and decide which changes to keep. You can choose to keep your changes, the incoming changes from the other branch, or a combination of both. Make your edits, then remove the conflict markers (`<<<`, `===`, `>>>`).

```git
 <<<<<<< HEAD
// Your changes
=======
// Incoming changes
>>>>>>> [branch name]
```

4. Save the File

Once you've resolved the conflict, save the file.

5. Add the Resolved File

Use `git add` command to stage the resolved file.

6. Continue the Merge

After resolving all conflicts, use `git commit` to finalize the merge.

`git commit -m "Resolved merge conflicts"`

7. Push Your Changes

`git push` your changes to the remote repository.

---

Merge conflicts can be complicated to resolve, so make sure you communicate with the person who created
the branch you have a conflict with to ensure you don't lose their work.

Remember that `Incoming` changes are from the other branch, while `Current` changes are from your branch.

It also doesn't hurt to use a tool that's purpose-built to resolve merge conflicts.
VS Code [has one built in](https://code.visualstudio.com/docs/sourcecontrol/overview#_3way-merge-editor), but there are a number of free options available online.

## Using GitHub

GitHub is a company that provides a service of hosting Git repositories online. There are many other alternative companies that provide a similar service, like BitBucket, GitLab, and Azure DevOps, but GitHub is the most popular one and the one our project teams use.

The instructions for the rest of this section will focus on GitHub's features. However, almost every feature described here has equivalents in the other git hosts, so if you know how to use one you generally know how to use them all.

### Pull requests

[Video intro to pull requests](https://www.youtube.com/watch?v=2VX1ISk9XH8&ab_channel=GitKraken)

A pull request is a way of merging code from one branch of your _remote_ repository into another.

![alt_text](images/image3.png)

You are _requesting_ that the _base_ branch _pulls_ the commits from the _compare_ branch.
In the above example, you are requesting that the main branch pulls the commits from the addLaunchEvent.
In other words, you are taking the changes from compare and putting them into base.

You will use pull requests extensively as part of your Git workflow.

We encourage teams to use small, frequent, single-feature PRs. Ideally each PR should be associated with only one branch, and each branch to only one PR. Each PR should have a name that describes exactly what the PR accomplishes. By doing smaller PRs, you will make sure everyone frequently updates their codebase so you don't end up with massive merge conflicts. By limiting your PR to a single feature, you also make it super easy to roll back that feature and reverse all commits in the PR by reverting the PR itself.

Advantages of pull requests:

- They enable your team to do pull request reviews (see more below)
- Your team can set up custom tests / deployments using CI/CD methods to ensure that your code runs as expected before you merge it
- It enables you to double check what code you are adding
- If you ever need to undo a pull request, it's very easy. Most git hosts have an easy way of reverting a pull request- usually it will create a new branch and PR itself, from which you can solve any merge conflicts and quickly roll back the code added from a previous PR.
- If you stick to coding 1 feature per pull request, it makes it very easy to understand the history of your repository

Sometimes, when you create a pull request, it will say there is a merge conflict. If this happens, don't force the PR to merge! Instead, you'll want to resolve the merge conflict.

Steps:

1. On your local machine, checkout to the "compare" branch - `git checkout addLaunchEvent`
2. Once you are on the compare branch, do a git pull from the base branch of your PR - `git pull origin main`
3. This will pull changes from the base into your compare branch. Git will notify you that this caused a merged conflict. This is okay!
4. Resolve the merge conflict according to the instructions in the [Merge Conflicts section](#merge-conflicts). You'll need to add and commit the files where you solved the merge conflict.
5. Confirm you have resolved every merge conflict. Try running/building your app again to make sure everything works as expected.
6. Push the commit(s) that solved the merge conflict to your remote compare branch `git push origin addLaunchEvent`
6. The pull request should now update saying there is no merge conflict! You can merge it now, as long as your team approves of it.

Additional readings on pull requests:

[GitHub Docs](https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/proposing-changes-to-your-work-with-pull-requests/about-pull-requests?platform=linux)

<https://product.hubspot.com/blog/git-and-github-tutorial-for-beginners>

<https://yangsu.github.io/pull-request-tutorial/>

### Pull Request Reviews

One of the main advantages of pull requests is that they enable you to do a pull request review, ensuring that code that gets pulled into your primary branches has been reviewed by your team to make sure it won't introduce code smells or bugs.

PRs provide the opportunity to review another developer's code and make sure that it meets the guidelines or practices that your organization or team has. For example, if you have a developer who is more familiar with the architecture of the software system, they can provide valuable input towards making sure that your changes fit within the long term architectural vision of the system.
Alternatively, you can have a newer team member who is not yet familiar with the overall code structure and they can add comments to specific parts of the code in a PR to ask for further clarification for why a certain change was made.

Aside from learning, PRs generally serve as a major communication channel for developers in industry, because they provide the opportunity for automated testing and improvements before your code changes are moved to the next deployment stages. One example of automated testing is using linter which is a static code analysis tool used to flag errors in your code such as bugs, stylistics errors, and suspicious constructs, like for example declaring a variable twice.

Whenever someone wants to merge a pull request, you should require them to get their PR reviewed first. To review a pull request, look at all the changes they made.

**Best Practices for PR Contributors:**

- Review your own PR before adding reviewers.
  - You may find some work-in-progress or experimental code. There could also be a typo, unintended indentation, or extra line breaks.
- Link your PR to your issue.
- Include a brief description of your changes.
- Push small incremental commits to your PR.
  - You can also mark your PR as a DRAFT PR in GitHub. This pre-commit review can be good practice to check with reviewers if you are going in the right direction before making any more code changes.
- Add additional comments to your PR to guide reviewers through the review.
  - Highlight areas reviewers should focus on.
  - Clarify changes with comments and additional references.
  - Favor adding code comments over PR comments as the code comments will out survive the PR comments.

### Best Practices for Reviewers

- Be fast, not furious
  - Responsiveness and turnaround time are very important to keep PRs healthy and not go stale due to other changes which may have been merged during the time that the PR is open and may even introduce new merge conflicts.
  - Either as a reviewer or as an author, you should keep the conversation actively going until the issue is resolved.
  - As a rule of thumb, if the PR is small or trivial, you should review it within one business day.
  - Plus, context switching is very expensive in industry. Many developers, like myself, have the memory of a goldfish when it comes to remembering the code we wrote a day ago. So, as a courtesy, you can let the developer who opened the PR know if you are planning on looking at their PR at a later time. If there are PRs open, it is also good practice to review them before you create a new one yourself.
- If there are outstanding comments or the PR is in draft mode, do not approve the PR.
  - Instead, stay involved and follow the discussions and new changes to see how the PR pans out.
- Do NOT rubber stamp reviews.
  - If you do not understand a change, you can ask for clarification or justification in the comments.
  - You do not have to approve a PR if you are not actually approving the change. You can let the author know that you have completed your review but are not weighing in on the approval.
  - Our TechStart website team's default PR policy requires approvals from 2 different reviewers, but an approval that is rubber stamped can be more harmful than abstaining if it promotes bad practices and bugs to be user-facing.
- Provide constructive comments
  - Code reviews are an important step in ensuring we build high-quality software products. As a reviewer, it's your job to carefully read and think about the code you are reviewing, and provide constructive feedback or ask questions about the code if things are unclear.
  - If the code isn't formatted correctly, too confusing, contains mistakes, or follows poor conventions, leave a comment to tell them what they did wrong and how they might be able to fix it (but phrase everything constructively! you don't want to seem rude or aggressive).
  - **If you disagree with something, give a reason and an example of a better solution. Let the author know exactly what you think is better.**

GitHub and other Git hosts support adding inline comments, so you can comment on specific areas of the code when necessary. The best place to do this is the "Files Changed" tab of a pull request.

It is up to them to address every issue that is brought up, and push the changes back to their branch. They should let you know when they've completed everything, and you can check to make sure you're happy with their changes.

## Our recommended Git workflow

Let's assume you have some commits on branch `yourLocalBranch`, and you want to merge them into a branch on your team's GitHub (which uses the default remote alias, `origin`) called `branchYouWantToMergeTo`.

**Part 1 - Set up your branch**:

1. Ensure you are on the main branch of your repository. It is usually called `main`. If you are not on the `main` branch, switch to it with `git checkout main`
2. Pull the most recent version of your main branch from GitHub. You can do this with `git pull origin main`. This will make sure your new branch contains all the most recent changes
3. Create a new branch for yourself. The name of the branch should describe what the code inside will do, and you should prefix it with your name or nickname. For example, `git branch joel/changeButtonColor`
4. Check out your new branch before you make any changes. Example: `git checkout joel/changeButtonColor`. Refer to [Branches](#branches) if you make any mistakes.

**Part 2 - Make your commits**:

1. Follow the instructions in the [Staging Files and Adding Commits](#staging-files--creating-commits) section to create a commit containing your desired changes. Use `git status` frequently to make sure you are doing everything correctly.

**Part 3 - Push your commits to origin**:

1. Push your branch to origin. Ex. `git push origin joel/changeButtonColor`
2. Set up a pull request on GitHub, with the base as main (or the branch you want to merge to) and the compare branch as your branch, (ex joel/changeButtonColor)
3. (Only if your pull request indicates you have a merge conflict): DO NOT merge the branch. Instead, do `git pull origin main` (or the branch you want to merge to) on your local machine. This will bring up the merge conflict.
4. Follow the instructions in [Merge Conflicts](#merge-conflicts) to fix any merge conflicts that you get from pulling that branch. Once you have fixed all merge conflicts, remember to double check that your code runs, then `git add` and `git commit` your fixes!
5. Push your changes to your remote repository! Do `git push origin yourLocalBranch`
6. Now that your changes are present on your remote repository, you should create a pull request on GitHub. The base (target branch) should be `branchYouWantToMergeTo`, and the source should be `yourLocalBranch`.
7. Check to make sure the pull request says "No merge conflicts". If it does detect merge conflicts, that means you didn't do steps 4-7 correctly, so redo them!
8. Request a reviewer for your pull request. They will read your code and offer suggestions on how to improve it.
9. Resolve the comments of your reviewer. Once they are resolved and your reviewer confirms you can proceed, you can merge the pull request on GitHub. Congratulations! Your code is now merged into your project.

**Clean up**:

1. Delete your branch on the remote repository
2. Delete your branch on your local system (checkout to main. Then delete with `git branch -d yourBranchName`)

## Big Picture Git/GitHub Workflow

Now that you understand the complete process on an individual level, let's take a step back to understand how your team will be using git.

Here is the Git workflow we recommend:

_This is what is used at Microsoft. It works well and it's good practice to teach it_.

1. When a team member wants to make changes or additions to the code, they should create a new branch for themselves. The branch name should describe what it does, ex. `fixButtonGlitch`
2. They `git push` their code to a branch on your origin repo that shares the same name
3. When they're ready, they create a Pull Request on GitHub. The PR's source should be their branch, and the destination should be `main`.
4. They should describe their Pull Request in the description and provide screenshots if applicable
5. They merge their own PR, once the following 3 conditions are met:
    1. There are no merge conflicts with the base branch
    2. If your project has Continuous Integration (which it should), the PR build succeeds
    3. At least 2 people have reviewed the code in the PR (more on code reviews later) and all comments from code reviews have been resolved
6. Upon merging the PR, they delete their branch.

## FAQ

- What should I do if I made a commit in the wrong branch?

  - Refer to [undoing changes and commits](#undoing-commits--changes)

- What should I do if I started work in the wrong branch but not committed yet?

  - Refer to [undoing changes and commits](#undoing-commits--changes)

- What if I want to revert a commit?

  - Refer to [undoing changes and commits](#undoing-commits--changes)

- How do I push code from my local branch to a remote branch that has a different name?
  - In order to push your branch to another remote branch, use the “git push” command and specify the remote name, the name of your local branch as the name of the remote branch

- How do I create a new local branch based on a pre-existing remote branch?

  - [https://www.git-tower.com/learn/git/faq/checkout-remote-branch/](https://www.git-tower.com/learn/git/faq/checkout-remote-branch/)

- What do I do if my pull request says it has merge conflicts?

  - See [Merge Conflicts section](#merge-conflicts)

## Advanced Section

Here are some advanced Git commands you can use to boost your Git game to the next level. They are not essential to using Git, but you may find them helpful. If you're still learning the beginner commands, we recommend focusing on them until you're comfortable with them before worrying about these advanced commands.

### Advanced Staging and Commits

Here are some additional commands and flags for existing commands that you can use while you are staging files and adding commits.

If you want descriptions of the basic staging and commits, please see [staging files & creating commits](#staging-files--creating-commits) in the beginner part of the guide.

### `git status (-s) (-v)`

(`-s`) displays information in a shortened and fast format

(`-v`) displays information in more detail, with additions such as the textual changes of uncommitted files

### `git add [fileName or folderName] (-u)`

You can use the `-u` flag on `git add` for the following effects:

(`-u`) adds new/modified files and IGNORES deleted files to the staging area

### `git commit (-a) (-am) "[Commit message here]"`

You can use the `-a` and `-am` flags on `git` commit for the following effects:

(`-a`) commits all files in the staging area

(`-am`) commits all files in the staging area and allows the addition of the commit message in the command

`"[Commit message here]"` the message that will be attached to the commit. Only usable if `-m` or `-am` is used; otherwise, a text editor will appear for the commit message.

## Git Stash

[Tutorial](https://www.atlassian.com/git/tutorials/saving-changes/git-stash)

### 🚧 Under Construction 🚧

<!-- should include push, pop, apply, list -->

## Git Clean

[Tutorial](https://www.atlassian.com/git/tutorials/undoing-changes/git-clean)

### 🚧 Under Construction 🚧

<!-- should include push, pop, apply, list

== didnt realize we already have git clean there, but we can do more detail here == -->

## Undoing Commits & Changes

Below is the general sequence of commands to check, and undo previous commits. Notice that we must use the commit comments as the easiest factor in differentiating between commits. It is important to use a descriptive comment for each commit.

### `git log`

Displays old commits with the ID hash and commit comment on the current branch.

`git checkout [id hash]`

Will make your working directory match the exact state of the id’ed commit.

Nothing you do here will be saved to the current state of the project (to go back do `git checkout main`).

### `git clean (-f) (-n)`

git clean -n shows which UNTRACKED files will be removed, should you do git clean -f.

Good practice is to always `-n` before you `-f`. [Learn more](https://www.theserverside.com/blog/Coffee-Talk-Java-News-Stories-and-Opinions/How-to-use-the-git-clean-command<)

(`-n`) runs a dry run (previews what files would be removed).

(`-f`) to force untracked file detection (removes the files).

### `git revert`

Undoes a single commit.

`git reset [id hash]`

Goes back to the specified commit by removing all subsequent commits.

## Git Rebase and Git Merge

### `git merge [branchName]`

Merges the specified branch into the branch that your local directory is currently on.
In a typical workflow, you will not need to use this command ever.
Instead, git pull and pull requests will handle all merging for you.

### 🚧 Under Construction 🚧
