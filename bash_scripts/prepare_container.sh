# install the python dependies from withn the container: 
pip3 install bitvector --break-system-packages

# install easel and hh-suite in the container
#apt-get install -y git
#apt-get install -y autoconf
git clone https://github.com/EddyRivasLab/easel
cd easel
autoconf
./configure
make
make check
cd ../
export PATH="easel/miniapps/:$PATH"


mkdir programs
cd programs
git clone https://github.com/soedinglab/hh-suite.git .
cd hh-suite
mkdir build && cd build
cmake ..
make install
cd ../../../
export PATH="programs/hh-suite/build/bin:$PATH"


# get profileview
git clone http://gitlab.lcqb.upmc.fr/profileview/profileview.git
export PATH="profileview:$PATH"