# shape
enigma shape adapted for GridEngine and Slurm clusters

**setup:**

In the 3 main scripts, there is a line saying "Change this to your enigma directory". Do that.
You could also use the Ansible role in the MRI repo.

To enable the 3d renderer, make sure the "viewer" directory is being served by a webserver. Make sure the files directory is writable by whoever will be using it. 
Set the variable "urlPath" in loader.js to fit your server setup.

**shape processor usage:**

For slurm clusters, use the scripts ending in .slurm. For grid-engine clusters, use the scripts ending in .qsub. The after\_shape.sh script doesn't care what kind of cluster you have.

Run each script without any arguments to get the usage information. First run "batch\_shape" to submit jobs. If they don't all process for some reason, run "gettherest" to get the rest of the subjects. When all jobs are done, run "after\_shape.sh" to generate 2 big csv files from the processed data. This one runs locally but should only take a few minutes.

**shape viewer usage:**

Go to a subject directory with the shape output files (specifically the resliced\_mesh files) and run the "render" script (not render.js) to copy to files to the rendering directory.
Go to the url where the rendering script is being served to see the 3d render.

**License:**

MIT
