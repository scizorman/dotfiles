#!/bin/sh
export SETUP_DIR

# Export SETUP_DIR variable to initialize.
if is_osx; then
    export SETUP_DIR=$DOTPATH/etc/init/osx

elif is_linux; then
    if is_debian; then
        SETUP_DIR=$DOTPATH/etc/init/linux/debian
    elif is_redhat; then
        SETUP_DIR=$DOTPATH/etc/init/linux/redhat
    fi

else
    echo 'Sorry. Your platform is not supported.'
    return 0
fi

# Initialize
if [ -e $SETUP_DIR ]; then
    for file in `ls $SETUP_DIR`; do
        source $file
    done
fi
