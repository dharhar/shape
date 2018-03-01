#!/bin/bash
#$ -S /bin/bash
#$ -o /ifshome/$USER/log -j y


#-------Change this to your enigma directory
runDirectory=/usr/local/shape/enigma



runFS=$1
outDirectory=$2
logdir=$3
groupfile=$4

#set runFS to the freesurfer output directory containing the subjects

function usage {
cat<<EOF

USAGE: 

$0 [Freesurfer results directory] [Shape output directory] [logfile directory] [ groupfile ]

Use this script just like batch_shape but with a different name for the groupfile. This one is for if some of the subjects fail to process, like when a compute node causes trouble for the job scheduler. Make sure you use the exact same arguments as the batch_shape command, but with a different csv groupfile name. This script will find and process all the subjects that did not get processed properly last time.

EXAMPLE:

$0 /U1/tated/FreeSurferProcessed /U1/hardyd/shapeOutput/shapeProcessed /U1/hardyd/shapeOutput/ /U1/hardyd/shapeOutput/remaining.csv

EOF
}

if [[ $# -eq 0 ]]; then
  usage
  exit 1
fi


timestamp=`date +"%m-%d-%Y"`
logdir=${logdir}/log-${timestamp}
setROIS="10 11 12 13 17 18 26 49 50 51 52 53 54 58"

#setROIS="26 58" 
#for testing only


mkdir -p $outDirectory
mkdir -p $logdir

subjects=$(ls -d ${outDirectory}/*)
rm $groupfile
touch $groupfile

for subject in $subjects; do
  numfiles=`ls $subject | wc -l`
  if [ $numfiles -lt 57 ]; then
    echo "${subject##*/},PAT" >> $groupfile
  fi
done;

FS=/usr/local/freesurfer/
FS_binary=${FS}bin/



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


		cmd="sbatch -o ${logdir}/${subject}.txt /${runDirectory}/medial.sh ${runFS} ${subject} ${outDirectory}/${subject}/ ${runDirectory} ${setROIS}"

		echo $cmd
		echo $cmd > ${outDirectory}/${subject}/run_notes.txt
		eval $cmd >> ${outDirectory}/${subject}/run_notes.txt
	fi

  #sleep 1
done

