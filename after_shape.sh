#!/bin/bash
#$ -S /bin/bash
#$ -o /ifshome/$USER/log -j y


#-------Change this to your enigma directory
runDirectory=/U1/hardyd/shape/enigma


outDirectory=$1
groupfile=$2

#groupfile=`pwd`/groupfile.csv
#outDirectory=`pwd`/`basename $runFS`shaped


FS=/usr/local/freesurfer/
FS_binary=${FS}bin/


setROIS="10 11 12 13 17 18 26 49 50 51 52 53 54 58"


function usage {
cat<<EOF

USAGE: 

Run this script after the jobs submitted by shapegroupqsub.sh are completed. You can check them with 'qstat'.

$0 [Shape output directory] [ groupfile ]
  Give the full pathname for each argument.
  1st arg: Shape output directory. Same as the 2nd argument used for the shapegroupqsub.sh script.
  2nd arg: csv file with list of subjcts. Same as the 4th argumnent used for the shapegroupqsub.sh script.

EXAMPLE:

$0 /U1/hardyd/shapeOutput/shapeProcessed /U1/hardyd/shapeOutput/subjectlist.csv

EOF
}

if [[ $# -eq 0 ]]; then
  usage
  exit 1
fi


filename=$(basename "${groupfile}")
#echo ${filename}
extension="${filename##*.}"
#echo ${extension}
filename="${filename%.*}"
#echo ${filename}


cmd="${runDirectory}/MedialDemonsShared/bin/raw_list2CSV_matrix ${outDirectory}/${filename}_LogJacs.csv ${runDirectory}/MedialDemonsShared/atlas GOF ${setROIS} LogJacs resliced_mesh ${groupfile} ${outDirectory}"
echo $cmd
eval $cmd

cmd="${runDirectory}/MedialDemonsShared/bin/raw_list2CSV_matrix ${outDirectory}/${filename}_thick.csv ${runDirectory}/MedialDemonsShared/atlas GOF ${setROIS} thick resliced_mesh ${groupfile} ${outDirectory}"
echo $cmd
eval $cmd

