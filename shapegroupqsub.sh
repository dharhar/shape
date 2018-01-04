#!/bin/bash
#$ -S /bin/bash
#$ -o /ifshome/$USER/log -j y

runFS=$1
outDirectory=$2
logdir=$3
groupfile=$4

#-------Change this to your enigma directory
runDirectory=/U1/hardyd/shape/enigma



#commented testing parameters
#runFS=/U1/tated/FreeSurferProcessed
#outDirectory=/U1/hardyd/shapeOutput/shapeProcessed
#groupfile=/U1/hardyd/shapeOutput/subjectlist.csv
timestamp=`date +"%m-%d-%Y"`
#logdir=/U1/hardyd/shapeOutput/log-${timestamp}


function usage {
cat<<EOF

USAGE: 

$0 [Freesurfer results directory] [Shape output directory] [logfile directory] [ groupfile ]

  Give the full pathname for each argument.
  1st arg: Directory with subjects you want to process. eg: /path/to/subjects/
  2nd arg: Output directory. It will be created if it doesn't already exist. eg: /path/to/output/
  3rd arg: A log file directory will be created with a timestamp. Where do you want it? eg: /path/to/logs/
  4th arg: A csv file with all the subjects will be created. What do you want to call it? eg: /path/to/groupfile.csv

EXAMPLE:

$0 /U1/tated/FreeSurferProcessed /U1/hardyd/shapeOutput/shapeProcessed /U1/hardyd/shapeOutput/ /U1/hardyd/shapeOutput/subjectlist.csv

Afterwards, use qstat to see if all the subjects are processed. When they're all done you can run shapeafterqsub.sh to create csv files from the shape output.

EOF
}

if [[ $# -eq 0 ]]; then
  usage
  exit 1
fi



logdir=${logdir}/log-${timestamp}
setROIS="10 11 12 13 17 18 26 49 50 51 52 53 54 58"





mkdir -p $outDirectory
mkdir -p $logdir

subjects=$(ls $runFS)


rm $groupfile
touch $groupfile

for subject in $subjects; do
  echo "$subject,PAT" >> $groupfile
done;

FS=/usr/local/freesurfer/
FS_binary=${FS}bin/


echo Input dir: $runFS
echo Output dir: $outDirectory
echo Logfile dir: $logdir
echo Groupfile: $groupfile





cmd="export FREESURFER_HOME=${FS}"
echo $cmd
eval $cmd
        

for subject in `cut -d',' -f1 ${groupfile}` ; do

	echo sending subject $subject to qsub
	
	if [ ${subject} = "id" ]; then
    		continue
    		
    	elif [ ${subject} = "SubjID" ]; then
    		continue 
    	
	else

		mkdir -p ${outDirectory}/${subject}/

		cmd="qsub -o ${logdir}/${subject}.txt -j y -S /bin/bash /${runDirectory}/medial.sh ${runFS} ${subject} ${outDirectory}/${subject}/ ${setROIS}"

		echo $cmd
		echo $cmd > ${outDirectory}/${subject}/run_notes.txt
		eval $cmd >> ${outDirectory}/${subject}/run_notes.txt
	fi

  sleep 1
done

