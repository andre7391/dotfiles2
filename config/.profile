# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi


# enviroment variables
export JAVA8=/flat/andre/programs/java/amazon-corretto-8
export JAVA11=/flat/andre/programs/java/amazon-corretto-11
export JAVA17=/flat/andre/programs/java/amazon-corretto-17
export JAVA_HOME=$JAVA8

export M2_HOME=/flat/andre/programs/maven/maven-3.6.3
export M2_REPO=/flat/andre/programs/maven/repository


export MATERA_CONFIG=/flat/andre/programs/matera/config
export MATERA_LOGS=/flat/andre/programs/matera/logs
export MATERA_KEYSTORE=/flat/andre/programs/matera/keystore

export TOMCAT_HOME=/flat/andre/programs/tomcat/tomcat-9


export PATH=$TOMCAT_HOME/bin:$M2_HOME/bin:$JAVA_HOME/bin:$PATH
