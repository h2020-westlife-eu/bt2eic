INSTALLING THE COURSE ON WINDOWS
================================

The recommended way to participate in the course is described in README.virtualbox.txt.
However, virus checkers are incompatible with VirtualBox.
Following these instructions is an alternative way to run the code.

# Download and install Anconda3.

# clone the git repository 
git clone https://github.com/h2020-westlife-eu/bt2eic.git

# open anaconda prompt via the start menu

# change into the course directory
cd bt2eic

# Create the anaconda environment using the yml file. Please ensure to specify 'conda env create' and not 'conda create' 
conda env create -n ml_course_env --file environment.yml python=3.6

# activate the environment and start jupyter:
activate ml_course_env
jupyter notebook &

# when finished, and dont forget to save your work! The conda environment can be deactivated using:
deactivate ml_course_env
