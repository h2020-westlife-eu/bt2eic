 Run from Vagrantfile the first time a VM is provisioned.
# To run again, you must do vagrant destroy
 

# operating system dependencies for virtualbox additions 
# Note do not yum update -y 
yum install -y kernel-headers gcc 
# note that dkms, often recommended for virtualbox, is unsstable in Centos

# could mount iso and
# cd /media/VirtualBoxGuestAdditions
# ./VBoxLinuxAdditions.run

# requirements for rdkit.Chem
yum install -y libXrender libXext

# requirement for pydot
yum install -y graphviz

# requirement for Theano
#yum install -y gcc-c++ epel-release
#yum install -y openblas

#Install miniconda - remove any previous folders for miniconda
#TODO rm -r /home/vagrant/miniconda2/ || true
for i in 1 2 3 4 5; do
        wget -c https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh && break
        sleep 15
        echo 'Retrying bash download'
done

bash Miniconda3-latest-Linux-x86_64.sh <<HERE1
yes
\r
\r
yes
miniconda3
no
HERE1

export PATH=/home/vagrant/miniconda3/bin:$PATH

# import the Python dependencies
for i in 1 2 3 4 5; do
	/home/vagrant/miniconda3/bin/conda env update -q -f /vagrant/environment.yml -n root && break
	sleep 15
	echo 'Retrying conda env create'
done

echo 'Please wait...'

#source activate root
# allow vagrant user to traverse to ananconda folder
chmod a+x /root
echo 'export PATH=$PATH:/home/vagrant/miniconda3/bin/' >> /home/vagrant/.bashrc
echo 'source activate root' >> /home/vagrant/.bashrc
# jupyter will use root environment when started by systemd

# config for jupyter
# note that the port is open
# the host machine is responsible for firewalling.
mkdir /etc/jupyter/
cat > /etc/jupyter/jupyter_notebook_config.py <<HERE
c.NotebookApp.ip = '0.0.0.0'
c.NotebookApp.notebook_dir = '/vagrant/' 
c.NotebookApp.token = u''
HERE
# TODO see http://stuartmumford.uk/blog/jupyter-notebook-and-conda.html 

# enable jupyter
cat > /usr/lib/systemd/system/jupyter.service <<HERE0
[Unit]
Description=jupyter

[Service]
Type=simple
Environment="PATH=/home/vagrant/miniconda3/bin:/usr/local/bin:/usr/bin"
PIDFile=/var/run/jupyter.pid
User=vagrant
ExecStart=/home/vagrant/miniconda3/bin/jupyter notebook --no-browser
ExecStop=/usr/bin/pkill -f jupyter-notebook
# or ExecStop=kill $(pidof /e2e/bin/qa-jupyter-notebook-service-start) 
WorkingDirectory=/vagrant/notebooks

[Install]
WantedBy=multi-user.target
HERE0

# TODO ln -s '/usr/lib/systemd/system/ipython-notebook.service' '/etc/systemd/system/multi-user.target.wants/ipython-notebook.service'

echo 'Starting Jupyter...'

systemctl daemon-reload
systemctl enable jupyter

# also done as a trigger after up
systemctl start jupyter
echo 'Please visit http://localhost:8888/notebooks/Welcome.ipynb'
