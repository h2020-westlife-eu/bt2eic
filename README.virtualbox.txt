Repository for machine learning course to be given in 2018.

Folders include:
raw_data - raw data files used in modelling
notebooks - jupyter ipython notebooks, a notebook is used for each lesson
img - stock image files
lib - stock functions for saving and loading models
model_data - empty folder, location for saving models

#Setting up vagrant-------------------------------------------------------

# To run these please ensure you have the following installed:
# Vagrant 1.9.6 (https://releases.hashicorp.com/vagrant/1.9.6/)
# VirtualBox 5.1.30 (https://www.virtualbox.org/wiki/Download_Old_Builds_5_1)
# Vagrant 2 and VirtualBox 5.2 have some defects.

#If you are behind an HTTP proxy:
export http_proxy=http://user:password@host:port
export https_proxy=https://user:password@host:port
vagrant plugin install vagrant-proxyconf


# For all users: plugins to install
vagrant plugin install vagrant-triggers
vagrant plugin uninstall vagrant-vbguest

#Creating the vagrant box ------------------------------------------------

# The course is designed to run on a machine with 8G of RAM.
# If you need to reduce this, edit this line of the Vagrantfile:
#   vb.memory = "8192"

#All packages are set to be installed on a vagrant box that needs to be created first.
#To create it please do the following:

cd ml-for-cheminformatics-course
vagrant up
# this takes several minutes

#If there are any issues, please check the logs by:
vagrant ssh -c 'cat /var/log/vboxadd-install.log'
vagrant ssh -c 'sudo journalctl -r'

#if this is the first time using this box and get an SSL error:
#download manually and install
curl -v -L -o centos.box -k  https://vagrantcloud.com/bento/boxes/centos-7.4/versions/201710.25.0/providers/virtualbox.box
vagrant box add bento/centos-7.2 centos.box

#Suspending and resuming the vagrantbox -----------------------------------

#After working, please stop the vagrant box session (don't forget to save any work!)
vagrant halt
#To start again after the vagrantbox has been created
vagrant up

#Beginning the course -----------------------------------------------------
# Visit  http://127.0.0.1:8888/notebooks/Welcome.ipynb
