# phylogenetics

The usage for running the entire program is:

./run.sh <genetreesfile> <outfile> <index>

where <genetreesfile> is a file containing a collection of trees in .newick format with one tree per line, and <outfile> is the name of the file in which the species tree in .newick format will be written to.  <index> is a number 1-5 that specifies which weight formula will be used to weight quartets.  
Use them as follows:

1- AllFullFormula: A weight formula found using baysian statistics
2- AllNumeratorOnly: Solely the numerator of the weight formula
3- AllWeightAppearances: The number of times that the quartet appears will be the weight it is assigned.
4- AllWeightKOverN: The number of times the quartet appears divided by the number of times all 3 quartet topologies appear will be the weight
5- OneThirdWeight1: Only the quartet topology that appears most often will be used with a weight of 1.  The other two quartets will be ignored.

You must also have the programs quartet-controller.sh, quartet-count.sh, summarize_quartets_stdin.pl and triplets.soda2103 in order to run this program.  These can be found at https://github.com/redavids/phylogenetics-tools/tree/master/quartets

In two of these programs you must change the directory paths.  Change each "~/phylogenetics/quartets/" to your directory path.  You will have to twice in the pgoram quartet-controller.sh, and once in quartet_count.sh.

If you want to delete taxa use the R program DeleteDate.R.  Change "~Desktop/genetrees" to your directory path, where "genetrees" is the name of your gene tree file in .newick format.  Change the 0.60 in "threshhold <- 0.60" to be the percentage of taxa you want to delete.  Then change "~/Desktop/outtree" to your directory path, where "outtree" is the file name you want for the updated tree.  
