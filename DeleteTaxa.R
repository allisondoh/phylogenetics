setwd("~/Desktop")

# get the required project to run the program
#install.packages("ape")
library(ape)
#install.packages("phangorn")
library(phangorn)

# get data to build up the gene trees 
true.trees <- read.tree(paste0("~/Desktop/genetrees")) 

print(inc);
threshhold <- 0.60
new <- vector('integer')
for (a in 1:1000){
  one.tree <- true.trees[[a]]
  drops <- vector('integer')
  for (b in 1:50){
    random <- runif(1, 0, 1)
    tip <- b
    if (random < threshhold){
      drops <- append(drops, b)
    }
  }
  if (length(drops) > 47){
    new <- append(new, a)
  }
  else{
    true.trees[[a]] <- drop.tip(one.tree, drops)
  }
}
trees <- vector('integer')
for (c in 1:1000){
  if (!(c %in% new)){
    trees <- append(trees, c)
  }
}
new.trees <- true.trees[trees]

write.tree(new.trees, file = paste0("~/Desktop/outtree"), append = FALSE,
           digits = 10, tree.names = FALSE)
