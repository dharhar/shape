#!/bin/bash

roistring=""
re='^[0-9]+$'
for arg in $@; do
  if [[ $arg =~ $re ]] ; then
    roistring=$roistring' '$arg
  fi
done

datadir=$1
subj=$2
outdir=$3
runDirectory=$4
#for testing:
#roistring="10 26"

perl /${runDirectory}/MedialDemonsShared/bin/Medial_Demons_shared.pl ${datadir}/${subj}/mri/aseg.mgz ${roistring} ${outdir} /${runDirectory}/MedialDemonsShared/ /usr/local/freesurfer/bin/

