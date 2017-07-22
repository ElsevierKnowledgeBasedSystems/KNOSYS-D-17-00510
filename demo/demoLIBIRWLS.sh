#!/bin/bash

myDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

echo "***************************************************"
echo "* DOWNLOADING DATASETS FROM THE LIBSVM REPOSITORY *"
echo "***************************************************"

mkdir -p ${myDIR}/../data
echo "Downloading ADULT dataset for training: a9a"
wget  -q -O ${myDIR}/../data/a9a 'https://www.csie.ntu.edu.tw/~cjlin/libsvmtools/datasets/binary/a9a'
echo "Downloading ADULT dataset for testing: a9a.t"
wget  -q -O ${myDIR}/../data/a9a.t 'https://www.csie.ntu.edu.tw/~cjlin/libsvmtools/datasets/binary/a9a.t'



file=${myDIR}"/../bin/full-train"
if [ -f "$file" ]
then

file=${myDIR}"/../bin/LIBIRWLS-predict"
if [ -f "$file" ]
then

echo "*************************************************"
echo "* RUNNING FULL SVM USING 1 THREAD               *"
echo "*************************************************"
echo " "
${myDIR}/../bin/full-train -c 1000 -g 0.001 -t 1 ${myDIR}/../data/a9a ${myDIR}/../data/a9a.model


echo "**************************************************"
echo "* TRAINING FULL SVM USING 2 THREADS              *"
echo "**************************************************"
echo " "
${myDIR}/../bin/full-train -c 1000 -g 0.001 -t 2 ${myDIR}/../data/a9a ${myDIR}/../data/a9a.model

echo "*****************************************************"
echo "* USING THE MODEL CREATED TO CLASSIFY A NEW DATASET *"
echo "*****************************************************"
echo " "
${myDIR}/../bin/LIBIRWLS-predict -l 1 -t 1 ${myDIR}/../data/a9a.t ${myDIR}/../data/a9a.model ${myDIR}/../data/a9a.output

else
echo "$file not found. Please, build this code using the make command."
fi

else
echo "$file not found. Please, build this code using the make command."
fi



file=${myDIR}/"../bin/budgeted-train"
if [ -f "$file" ]
then

file=${myDIR}/"../bin/LIBIRWLS-predict"
if [ -f "$file" ]
then

	echo "*******************************************************"
	echo "* RUNNING SEMIPARAMETRIC SVM (PSIRWLS) USING 1 THREAD *"
	echo "*******************************************************"
	echo " "
	${myDIR}/../bin/budgeted-train -c 1000 -g 0.0001 -s 75 -t 1 ${myDIR}/../data/a9a ${myDIR}/../data/a9a.model

	echo "********************************************************"
	echo "* RUNNING SEMIPARAMETRIC SVM (PSIRWLS) USING 2 THREADS *"
	echo "********************************************************"
	echo " "
	${myDIR}/../bin/budgeted-train -c 1000 -g 0.0001 -s 75 -t 2 ${myDIR}/../data/a9a ${myDIR}/../data/a9a.model

	echo "*****************************************************"
	echo "* USING THE MODEL CREATED TO CLASSIFY A NEW DATASET *"
	echo "*****************************************************"
	echo " "
	${myDIR}/../bin/LIBIRWLS-predict -l 1 -t 1 ${myDIR}/../data/a9a.t ${myDIR}/../data/a9a.model ${myDIR}/../data/a9a.output


else
	echo "$file not found. Please, build this code using the make command."
fi

else
	echo "$file not found. Please, build this code using the make command."
fi

