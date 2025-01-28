library(ggplot2)
library(tidyverse)
library(usethis)
library(git2r)
library()



repo <- git2r::repository("")
git2r::add(repo, "*")  # Stage all changes
git2r::commit(repo, "Your commit message")
git2r::push(repo)