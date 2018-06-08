#!/bin/sh
cat << START

************************************************
START TO INSTALL PYTHON PACKAGES!!
************************************************

START


# Install Python2.7 packages
pip2 install -r $SETUP_DIR/neovim_py2_requirements.txt

# Install Python2.7 packages
pip3 install -r $SETUP_DIR/neovim_py3_requirements.txt


cat << END

************************************************
COMPLETE TO INSTALL PYTHON PACKAGES!!
************************************************

END
