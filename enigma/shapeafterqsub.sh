#!/bin/bash
#$ -S /bin/bash
#$ -o /ifshome/$USER/log -j y

outDirectory=$1
groupfile=$2

#groupfile=`pwd`/groupfile.csv
#outDirectory=`pwd`/`basename $runFS`shaped


FS=/usr/local/freesurfer/
FS_binary=${FS}bin/
runDirectory=/U1/hardyd/shape/enigma


setROIS="10 11 12 13 17 18 26 49 50 51 52 53 54 58"


function usage {
cat<<EOF

USAGE: 

Run this script after the jobs submitted by shapegroupqsub.sh are completed. You can check them with 'qstat'.

$0 [Shape output directory] [ groupfile ]
  Give the full pathname for each argument.
  1st arg: Directory with subjects you want to process. eg: /path/to/subjects/
  2nd arg: Output directory. It will be created if it doesn't already exist. eg: /path/to/output/
  3rd arg: Directory to put the log files. It will be created if it doesn't already exist. eg: /path/to/logs/
  4th arg: CSV file the program will generate with a list of all the subjects. eg: /path/to/groupfile.csv

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
#eval $cmd

cmd="${runDirectory}/MedialDemonsShared/bin/raw_list2CSV_matrix ${outDirectory}/${filename}_thick.csv ${runDirectory}/MedialDemonsShared/atlas GOF ${setROIS} thick resliced_mesh ${groupfile} ${outDirectory}"
echo $cmd
#eval $cmd

