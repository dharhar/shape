# shape
enigma shape adapted for qsub and slurm clusters

**setup:**

In the 3 main scripts, there is a line saying "Change this to your enigma directory". Do that.

To enable the 3d renderer, make sure the index.html file in the viewer directory is being served by a webserver, and make sure that directory is writable by whoever will be using it.

**shape processor usage:**

For slurm clusters, use the scripts ending in .slurm. For grid-engine clusters, use the scripts ending in .qsub. The after\_shape.sh script doesn't care what kind of cluster you have.

Run each script without any arguments to get the usage information. First run "batch\_shape" to submit jobs. If they don't all process for some reason, run "gettherest" to get the rest of the subjects. When all jobs are done, run "after\_shape.sh" to generate 2 big csv files from the processed data. This one runs locally but should only take a few minutes.

**shape viewer usage:**

Go to a subject directory with the shape output files (specifically the resliced\_mesh files) and run the viewer/render script to copy to files to the rendering directory.
Go to the url where the rendering script is being served to see the 3d render.
