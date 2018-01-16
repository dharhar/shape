# shape
enigma shape adapted for qsub

**setup:**

In the 3 main scripts, there is a line saying "Change this to your enigma directory". Do that.

**usage:**

Run each script without any arguments to get the usage information. First run "shapgroupqsub.sh" to submit jobs. If they don't all process for some reason, run "gettherest.sh" to get the rest of the subjects. When all jobs are done, run "shapeafterqsub.sh" to generate 2 big csv files from the processed data. This one runs locally but should only take a few minutes.
