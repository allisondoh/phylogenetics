#!/bin/bash
echo "Start time: "
date

#finds the quartets and writes them to "quartets"
./quartet-controller.sh $1 quartets
#finds the total amount of times each quartet occurs, writes it to "totalquartets"
perl total_quartets.pl quartets totalquartets

#uses the weight formula
if [ $3 == "1" ]
then
    java AllFullFormula totalquartets weightedquartets
elif [ $3 == "2" ]
then
    java AllNumeratorOnly totalquartets weightedquartets
elif [ $3 == "3" ]
then
    java AllWeightAppearances totalquartets weightedquartets
elif [ $3 == "4" ]
then
    java AllWeightKOverN totalquartets weightedquartets
elif [ $3 == "5" ]
then
    java OneThirdWeight1 totalquartets weightedquartets
fi

#else if other, just use original weight formula

#builds up the tree using MaxCut
./max-cut-tree qrtt=weightedquartets weights=on otre=$2

echo "End time: "
date


