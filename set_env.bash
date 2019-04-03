#!/bin/bash

# Set BLOGVILLAIN_HOME
PROFILE="$HOME/.profile";

source "$PROFILE";

if [ -z "$BLOGVILLAIN_HOME" ]; then
	echo "\$BLOGVILLAIN_HOME Does not exist"
	echo "" >> $PROFILE
	echo "" >> $PROFILE
	echo "# set ENV for BlogVillain" >> $PROFILE
	echo "export BLOGVILLAIN_HOME=$HOME/blog_villain" >> $PROFILE
	echo "export PATH=\$BLOGVILLAIN_HOME/bin:\$PATH" >> $PROFILE
	source "$PROFILE";
fi
