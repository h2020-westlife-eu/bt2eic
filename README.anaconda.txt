INSTALLING THE COURSE ON WINDOWS
================================

The recommended way to participate in the course is described in README.virtualbox.txt.
However, some pharmaceutical companies have virus checkers that are incompatible with VirtualBox.
Following these instructions is an alternative way to participate.

# Download and install Anconda3.

# clone the git repository 
git clone https://bitbucket.org/chrishmorris/ml-for-cheminformatics-course.git

# open anaconda prompt via the start menu

# change into the course directory
cd ml-for-cheminformatics-course

# Create the anaconda environment using the yml file. Please ensure to specify 'conda env create' and not 'conda create' 
conda env create -n ml_course_env --file environment.yml python=3.6

# activate the environment adn start jupyter:
activate ml_course_env
jupyter notebook &

# when finished, and dont forget to save your work! The conda environment can be deactivated using:
deactivate ml_course_env
