## Overview of workflow and scripts

There is a separate Dockerfile (currently located on the server: ches1/swohlrab/profileview_docker). It installs serveral dependencies, but they do depend on the version used, as some commands have changed in the different versions.
For MMseqs2: MMseqs2 Version: 12-113e3+ds-3+b1 
For python3: Python 3.9.2 (default, Feb 28 2021, 17:03:44)
For Hmmer: HMMER 3.3.2 (Nov 2020); http://hmmer.org/
For hh-suite: git-repo version from 06.2023

--> specify the version already in the Dockerfile (so nothing can go worng)

# build the image and start the container
as to be adjusted depend on the directories. Here the docker vm runs on a server, which is located to my server home directory. So I first clone this image here into my home directory, eg with (from inside albedo in the folder)

git clone https://github.com/MelissaMisir/phyla_analysis

and set the permissons to
chmod -R 777 MaMiMePro


I connect to my docker vm from the terimal: (number might change)

ssh swohlrab@10.7.0.89

I cd to the directory: cd <DIR>
An then build the image with docker compose: docker compose build
get the name of the container image: docker image ls

# set up working environemnt and start the container:
# start the container, mount the volume and set the user in order to avoid permission conflicts, add -d to start in detached mode. The mouted volumen contains at the moment already my hhblits databse, but his was build before with the same container. In this mounted volume, also all data can be written so they are instandt available as a copy in this folder.
screen -S mamimepro docker run -it -v /isibhv/projects/AG_John/Group/Sylke/hhblits_db_mmetsp/data:/data mamimepro-mamimepro #--user $(id -u):$(id -g) -d

# on another terminal, umask the folder at server to that all files that get stored in there automatically get permissions to be usable by the docker contianer: go the folder and make:
umask 022

# detach from your process before closing all:
Clrl+A and then press d.
# to check screen running containers
screen -ls 
# reattach to screen session:
screen -r 634506.profiledocker
# or if there is only one session, no name is needed
screen -r
# or if no process is running:
screen -d -r 
# at the very end, you can stop them all with but take care, if you use "exit" from within docker, all will also be terminated
screen -X -S "sessionname" quit

# once you are in the container, you can prepare the container to install missing dependencies
# prepare the docker container
run the script "prepare_container.sh" from the bash_scripts folder
bash bash_scripts/prepare_container.sh #diesmal scheint es sogar mit den _mpi versions zu klappen..

# this works now fine, and should therefore also run nicely. Time so save a copy of the image of this version (to be sure)
exit #exit the container
docker images #get all the images ...see how to proceed on: https://www.dataset.com/blog/create-docker-image/ and copy it accoring to: https://www.linkedin.com/pulse/how-copy-docker-image-from-one-machine-another-abhishek-rana
In summary:
docker images
docker ps -a
docker start musing_heyrovsky
docker commit musing_heyrovsky
docker images -a
docker tag c6f62813bc5a mamimepro_image_copy
docker images -a
docker ps
docker stop musing_heyrovsky
docker ps -a
rm musing_heyrovsky
docker images
docker save -o mamimepro_image_working.tar mamimepro_image_copy:latest


# now we can also start this version of the container image, then there is no need to run the prepare container script over and over again
screen -S mamimepro docker run -it -v /isibhv/projects/AG_John/Group/Sylke/hhblits_db_mmetsp/data:/data mamimepro_image_copy #--user $(id -u):$(id -g) -d
# but the path has to be exported again
export PATH="easel/miniapps/:$PATH"
export PATH="profileview:$PATH"
export PATH="/programs/scripts/:$PATH"
