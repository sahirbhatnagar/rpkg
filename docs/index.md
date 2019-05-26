---
title: "Creating an `R` Package"
#subtitle: "An introduction"
author: by Sahir Rai Bhatnagar
output:
  rmdformats::readthedown:
    fig_width: 6
    fig_height: 6
    highlight: kate
    thumbnails: false
    lightbox: true
    gallery: true
    fig_caption: true
    keep_md: yes
    number_sections: true
    use_bookdown: true
bibliography: rpkg.bib
link-citations: yes
editor_options: 
  chunk_output_type: console
---




# Introduction

One of the fundamental roles of a statistician is to create methods to analyze data. This typically involves four components: developing the theory, translating the equations to computer code, a simulation study and a real data analysis. While these are enough to get published, it is unlikely your method will be used by others without a key fifth component: a software package. A package is a collection of reusable functions, the documentation that describes how to use them, tests and sample data. They provide a structured way to organize, use and distribute code to others and/or your future self. The objective of this workshop is to learn how to develop an `R` package. In addition to creating an `R` package from scratch, you will learn how to make it robust across platforms and future changes using continuous integration and unit testing. This workshop assumes familiarity with `R`, `RStudio`, writing functions, installing packages, loading libraries and requires a `GitHub` account. This will be an interactive workshop. 


<br><br>

# Pre-workshop set-up {#req}

You must bring your own laptop. **It is vital that you attempt to set up your system in advance. You cannot show up at the workshop with no preparation and keep up!**

* [R (version ≥ 3.6.0)](http://cran.r-project.org/)  
* [RStudio (version ≥ 1.2.1335)](https://www.rstudio.com/products/rstudio/download/#download). This is a powerful graphical user interface (GUI) which makes the package creation process much easier.  
* [Git](https://git-scm.com/downloads). I strongly recommend reading these [setup instructions by Jenny Bryan for Mac/Windows/Linux](https://happygitwithr.com/install-git.html) and the [Troubleshooting section](https://happygitwithr.com/troubleshooting.html).  
* Please read [Chapter 1: Why Git? Why GitHub?](https://happygitwithr.com/big-picture.html) to understand the big picture and motivation for using Git and Github.  
* [Sign up for a GitHub account](https://github.com/). We will use GitHub to host the source files of our `R` package. I also recommend reading [Jenny Bryan's advice on carefully choosing a username](https://happygitwithr.com/github-acct.html).  
* [GitKraken](https://www.gitkraken.com/). This is a GUI for Git which makes it much easier to dive into version control without the command line. GitKraken is to Git what RStudio is to R. This is optional but highly recommended, particularly for new Git users. You are free to use the GUI of your choice or simply the command line. In this workshop I will be using GitKraken.  
* Complete [Section 3](#gitgithub) of this tutorial.  
* Run the following commands in `R`:

```R
install.packages("pacman")
# this command checks if you have the packages already installed, 
# then installs the missing packages, then loads the libraries
pacman::p_load(knitr, rmarkdown, devtools, roxygen2, usethis) 

# identify yourself to Git with the usethis package
# use the exact same username and email associated
# with your GitHub account
usethis::use_git_config(user.name = "gauss", user.email = "gauss@normal.org")
```




<br><br>


<!-- # Git and GitHub {.tabset .tabset-fade .tabset-pills} -->

# Git and GitHub {#gitgithub}

## Introduction

This section walks you through the process of creating a GitHub repository (abbreviated as repo), creating a local copy of the repo (i.e. on your laptop), making some changes locally and updating your changes on the remote (aka GitHub repo). It assumes that you have successfully completed the requirements outlined in [Section 2](#req). The following figure summarizes some key terminology that we will make use of in this section:


<div class="figure">
<img src="assets/img/git/rpkg000.png" alt="source: http://ohi-science.org/data-science-training/" width="670" />
<p class="caption">(\#fig:github1)source: http://ohi-science.org/data-science-training/</p>
</div>

<br>

## Annotations

For each step, I have provided screenshots annotated with red rectangles, circles and arrows. You can click on each image to enlarge it. The following table describes what each of the annotations represent. 



Annotation                                                                                     Description                          
---------------------------------------------------------------------------------------------  -------------------------------------
<a href="assets/img/box.png"><img src="assets/img/box.png" style="width: 350px;"/></a>         Enter text or fill in the blank      
<a href="assets/img/circle.png"><img src="assets/img/circle.png" style="width: 350px;"/></a>   Click on the circled button          
<a href="assets/img/arrow.png"><img src="assets/img/arrow.png" style="width: 350px;"/></a>     Take note of. No action is required. 


<br>

## Step 1: Create a remote repo {#remote}

We first create a GitHub repo. Head over to https://github.com and login. Then click on new repository:

<img src="assets/img/git/rpkg001.png" width="1747" />


Give it a name. It can be anything you want (just pick a name that will remind you that this repository contains the source files of your `R` package). In the screenshots below I used `rpkg` throughout. Click on `Create repository`:

<img src="assets/img/git/rpkg002.png" width="1403" />

Copy the link of your newly created repo to your clipboard:

<img src="assets/img/git/rpkg003.png" width="1483" />


<br>

## Step 2: New `RStudio` Project via `git clone` {#clone}

Create a local copy of the remote repo using `RStudio` projects:

<img src="assets/img/git/rpkg004.png" width="1924" />

Click on `Version Control`:

<img src="assets/img/git/rpkg005.png" width="941" />

Click on `Git`. Note that if you get an error or you don't see this option, this likely means that your `RStudio` doesn't know where to find your local `Git` installation. Please see [Chapter 13: Detect Git from RStudio](https://happygitwithr.com/rstudio-see-git.html) for troubleshooting this.

<img src="assets/img/git/rpkg006.png" width="931" />


Paste the link to your remote repo in the `Repository URL` box, name the folder that will contain your `R` package files, and browse to where you want the folder to be saved in your filesystem. Click on `Create Project`:

<img src="assets/img/git/rpkg007.png" width="932" />


Your `RStudio` window should open a new project in the specfied directory. Take note of the following points annotated in the screenshot below:

1. The `Git` tab allows you to use `Git` and push to `GitHub` within `RStudio`. You will see any changes that have been made to your files since the last commit here. I have found the `RStudio` interface to `Git` to be inadequate and slow. I just want you to be aware of this functionality. I only look at this tab to quickly see if there were any changes, but do all my version controlling and interfacing with `GitHub` using `GitKraken`.
2. Shows the path of your working directory, which is set to the root of your `RStudio` project by default. You can always click on the arrow to return to the working directory. 
3. Indicates the name of your `Rstudio` project. It's also a dropdown menu for other recently opened `RStudio` projects. 
4. Filesystem viewer of your working directory. You should see a `.gitignore` file and the `RStudio` project file. These were automatically added by `RStudio` when you created a new project from a `GitHub` repo. 
5. A dropdown menu with extended `Git` functionalities. 


<img src="assets/img/git/rpkg008.png" width="1912" />


<br>

## Step 3: `add` and `commit` your changes {#add}

The following figure shows the commands needed for a basic version controlled workflow. Refer back to this figure once you complete [Step 3](#add) and then once again when you complete [Step 4](#push) (it should make a little more sense). 

<div class="figure">
<img src="assets/img/git/rpkg022.png" alt="source: https://www.edureka.co/blog/git-tutorial/" width="768" />
<p class="caption">(\#fig:unnamed-chunk-10)source: https://www.edureka.co/blog/git-tutorial/</p>
</div>



Have you ever versioned a file by adding your initials or the date? That is effectively a `commit`, albeit only for a single file: it is a version that is significant to you and that you might want to inspect or revert to later [@happygit]. The `commit` command is used to save your changes to the local repository. From the `Git` tab, click on `Commit`:


<img src="assets/img/git/rpkg009.png" width="646" />

Note that you have to explicitly tell `Git` which changes you want to include in a `commit` before running the `git commit` command. This means that a file won't be automatically included in the next commit just because it was changed. Instead, you need to use the `git add` command to mark the desired changes for inclusion. Instead of typing `git add` in the terminal, you can simply click the boxes next to the files you want to add (this is also referred to as _staging_ a file). The lines 1 to 4 highlighted in green refer to the contents of the `.gitignore` file and the green highlight indicates they are being added to the file (red highlight indicates removal of a line):

<img src="assets/img/git/rpkg010.png" width="998" />

Every time you make a `commit` you must also write a short `commit` message. Ideally, this conveys the motivation for the change. Remember, the diff will show the content. When you revisit a project after a break or need to digest recent changes made by a colleague, looking at the history, by reading commit messages and skimming through diffs, is an extremely efficient way to get up to speed [@happygit]. Enter a `commit` message and click on the `Commit` button:


<img src="assets/img/git/rpkg011.png" width="995" />


If everything worked, you should see the following screen with the `commit` message and the files that were added:

<img src="assets/img/git/rpkg012.png" width="862" />


<br>

## Step 4: `push` your local commits {#push}

The `push` command is used to publish new local commits on a `remote` server (the remote repo you created in [Step 1](#remote)):

<img src="assets/img/git/rpkg013.png" width="1000" />

Enter your username:


<img src="assets/img/git/rpkg014.png" width="990" />


and your password:

<img src="assets/img/git/rpkg015.png" width="993" />

Note the following:

1. The URL of the remote repo.
2. The name of the local branch called `master`. (We'll talk about branches later).
3. The name of the remote branch also called `master`. `master -> master` indicates that you have pushed the commit from the local `master` branch to the remote `master` branch.
4. The command you can enter in the terminal instead of using the `RStudio` interface to `push` your commit to the `remote`.


<img src="assets/img/git/rpkg016.png" width="994" />

Head over to your remote `GitHub` repo and take note of the following:

1. The newly added files.
2. The `commit` message.
3. You are currently viewing the contents of the `master` branch.
4. The unique ID of the `commit`. A Git commit ID is a [SHA-1 hash](https://en.wikipedia.org/wiki/Cryptographic_hash_function) of every important thing about the commit. Clicking on it will allow you to see the difference (aka `diff`) between the previous commit.
5. The number of commits (aka snapshots of the repo).
6. The number of branches. 

<img src="assets/img/git/rpkg017.png" width="1510" />


<br>

## Step 5: Open the repo with `GitKraken` {#kraken}

Link your `GitHub` account to `GitKraken`; you will be prompted for this when opening the `GitKraken` application for the first time. Open the local repo created in [Step 2](#clone):


<img src="assets/img/git/rpkg018.png" width="1920" />


<img src="assets/img/git/rpkg019.png" width="980" />


<img src="assets/img/git/rpkg020.png" width="1087" />

The following screenshot shows the local repo in the `GitKraken` GUI. Note the following (which has similar attributes to the online `GitHub` repo):

1. The newly added files.
2. The `commit` message.
3. You are currently viewing the contents of the `master` branch.
4. The unique ID of the `commit`. A Git commit ID is a [SHA-1 hash](https://en.wikipedia.org/wiki/Cryptographic_hash_function) of every important thing about the commit. Clicking on it will allow you to see the difference (aka `diff`) between the previous commit.
5. The branches available locally.
6. The branches available on the remote.

<img src="assets/img/git/rpkg021.png" width="1913" />


<br><br>

## Discussion

Hopefully you were able to successfully complete all the steps in this Section. The main takeaway is to be able to `add`, `commit`, and `push` your local commits to the remote repo. It's completely normal if you still have very little understanding of what just happened. I will clarify during the workshop. The point was for you to take a first stab at using version control and come to the workshop as prepared as possible. 


<br><br>



# Quick Start

This section runs through the development of a small toy package. It's meant to illustrate the most important components of an `R` package. We will then provide a detailed treatment of the key components in the next sections. 

<br>

## Package Structure

A package is a convention for organizing files into directories. Figure \@ref(fig:structure) shows the 7 most common parts of
an `R` package. 

<div class="figure">
<img src="assets/img/quick/quick001.png" alt="source: https://rawgit.com/rstudio/cheatsheets/master/package-development.pdf" width="496" />
<p class="caption">(\#fig:structure)source: https://rawgit.com/rstudio/cheatsheets/master/package-development.pdf</p>
</div>

1. `DESCRIPTION` file (**required**): contains key metadata for the package that is used by repositories like CRAN and by `R` itself. This file contains the package name, the version number, the author and maintainer contact information, the license information, as well as any dependencies on other packages.
2. `NAMESPACE` file (**required**): specifies the interface to the package that is presented to the user. This is done via a series of `export()` statements, which indicate which functions in the package are exported to the user. Functions that are not exported cannot be called directly by the user (or they must use `:::`). In addition to exports, the NAMESPACE file also specifies what functions or packages are imported by the package. If your package depends on functions from another package, you must import them via the NAMESPACE file.
3. `R` sub-directory (**required**): The R sub-directory contains all of your R code, either in a single file, or in multiple files. For larger packages it’s usually best to split code up into multiple files that logically group functions together. The names of the R code files do not matter, but generally it’s not a good idea to have spaces in the file names.
4. `man` sub-directory (**required**): contains the documentation files for all of the exported objects of a package. The `roxygen2` package allows you to write the documentation directly into the `R` code files. Therefore, you will likely have little interaction with the `man` directory as all of the files in there will be auto-generated by the `roxygen2` package from the `R` code files.
5. `tests` sub-directory: to store tests that will alert you if your code breaks.
6. `vignettes` sub-directory: holds documents that teach your users how to solve real problems with your tools.
7. `data` sub-directory: allows you to include data with your package.

<br>

## Create Required Files and Folders

We will rely heavily on the `usethis` package [@usethis] to create the required files and folders for us. Ensure that your working directory is set to the root of the GitHub repo you created in [Section 3](#gitgithub). The following shows a plain text listing of the directory:








```
-- .gitignore
-- rpkgs.Rproj
```





```
-- .gitignore
-- DESCRIPTION
-- NAMESPACE
-- R
   |__rpkgs-package.R
-- rpkgs.Rproj
```


## Documentation


\@ref(tab:tab1)


Table: (\#tab:tab1)Common `roxygen2` tags to use in creating documentation for R functions [@rdpeng]

Tag               Meaning                                                                                                                               
----------------  --------------------------------------------------------------------------------------------------------------------------------------
\@return          A description of the object returned by the function                                                                                  
\@parameter       Explanation of a function parameter                                                                                                   
\@inheritParams   Name of a function from which to get parameter definitions                                                                            
\@examples        Example code showing how to use the function                                                                                          
\@details         Add more details on how the function works (for example, specifics of the algorithm being used)                                       
\@note            Add notes on the function or its use                                                                                                  
\@source          Add any details on the source of the code or ideas for the function                                                                   
\@references      Add any references relevant to the function                                                                                           
\@importFrom      Import a function from another package to use in this function (this is especially useful for inline functions like %>% and %within%) 
\@export          Export the function, so users will have direct access to it when they load the package                                                




\@ref(tab:tab2)



Table: (\#tab:tab2)Common `roxygen2` formatting tags used in creating documentation for R functions [@rdpeng]

Tag           Meaning                                                                                
------------  ---------------------------------------------------------------------------------------
\\code{}      Format in a typeface to look like code                                                 
\\dontrun{}   Use with examples, to avoid running the example code during package builds and testing 
\\link{}      Link to another R function                                                             
\\eqn{}{}     Include an inline equation                                                             
\\deqn{}{}    Include a display equation (i.e., shown on its own line)                               
\\itemize{}   Create an itemized list                                                                
\\url{}       Include a web link                                                                     
\\href{}{}    Include a web link                                                                     


# Resources

1. [Cheat Sheet](https://rawgit.com/rstudio/cheatsheets/master/package-development.pdf)
2. [Mastering Software Development in R: Chapter 3](https://bookdown.org/rdpeng/RProgDA/building-r-packages.html)
3. Advanced R: [Version 1](http://r-pkgs.had.co.nz/) and [Version 2](https://r-pkgs.org/)
4. [Advanced R course: Chapter 6](https://privefl.github.io/advr38book/packages.html)




# References


















