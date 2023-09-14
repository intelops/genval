[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg?style=flat-square)](https://github.com/intelops/genval/pulls)
[![Open Source Love](https://badges.frapsoft.com/os/v1/open-source.png?v=103)](https://github.com/intelops/)

At Intelops, we warmly welcome contributions through collaboration. We are excited to see that you want to contribute!. There are many ways in which one could contribute to GenVal and every contribution is equally appreciated here. Navigate through the following to understand more about contributing here.

# New to Git

Follow these resources: https://lab.github.com and https://try.github.com/

# Contributing to GenVal

Please follow these steps and note these guidelines to begin contributing:

1. The first step is to set up the local development environment. See [this](#set-up-your-local-development-environment) on how to do the same.
1. Take a look at the existing [Issues](https://github.com/intelops/genval/issues) or [create a new issue!](https://github.com/intelops/genval/issues/new/choose)
1. A good way to easily start contributing is to pick and work on a [good first issue](https://github.com/intelops/genval/labels/good%20first%20issue) or [help wanted](https://github.com/intelops/genval/labels/help%20wanted). We try to make these issues as clear as possible and provide basic info on how the code should be changed, and if something is unclear feel free to ask for more information on the issue.


1. Add screenshots or screen captures to your Pull Request to help us understand the effects of the changes proposed in your PR.


## Set up your Local Development Environment

Make sure you have built the [application from source](./README.md/#build-from-source) on your operating system before you start contributing:
 
Clone the Genval repository:

```shell
git clone https://github.com/intelops/genval.git

# Navigate to the project directiry
cd genval

# Add a reference (remote) to the original repository
git remote add upstream https://github.com/intelops/genval.git
```

While contributing to `genval`, we would appreciate, if you work in your separate branch and push the changes to the branch. checkout to new branch:

```shell
git checkout -b <new branch>
```
`genval` is written in Golang, you can pull and resolve dependencies by running:

```shell
go mod tidy
```

And you are ready to roll...

You can track your changes.

```shell
git add  <file_name>
```

Commit your changes. To contribute to this project, you must agree to the [Developer Certificate of Origin (DCO)](https://github.com/dcoapp/app#how-it-works) for each commit you make.

```
git commit --signoff -m "<your commit message>"
```

or

```
git commit -s -m "<your commit message>"
```

Push the committed changes in your local branch to your remote repo.

```
git push -u origin <your_branch_name>
```

Once you’ve committed and pushed all of your changes to GitHub, go to the page for your fork on GitHub, select your development branch, and click the _pull request button_. Please ensure that you compare your feature branch to the desired branch of the repo you are supposed to make a PR to.

**_:trophy: After this, the maintainers will review the PR and will merge it if it helps move the genval project forward. Otherwise, it will be given constructive feedback and suggestions for the changes needed to add the PR to the codebase._**

**14.** While you are working on your branch, other developers may update the `main` branch with their branch. Such scenarios make your branch out of date with the `main` branch with missing content. So to fetch the new changes, follow along:

```
git checkout main
git fetch origin main
git merge upstream/main
git push origin
```

Now you need to merge the `main` branch into your branch. This can be done in the following way:

```
git checkout <your_branch_name>
git merge main
```

## All the best! 🥇