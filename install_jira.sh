#!/bin/bash

# install JIRA

# variables
# Currently all static here, will be overidable by CLI in the future.
echo "Reading global variables...." >&2

# local variables
export RESPONSEFILE="response.varfile"
export ATLASSIANROOT=/opt

# preflights
# check that /opt is mounted/exists.
if [ ! -e $ATLASSIANROOT ] # if /opt doesnt exist
then
  echo "$ATLASSIANROOT was not found. Dying."; exit
else
  echo "$ATLASSIANROOT was found. Continuing."
fi

# check that our DB server is available
# TODO

# be in the users homedir
cd ~ || exit

# download the binary
wget -q https://www.atlassian.com/software/jira/downloads/binary/atlassian-jira-software-7.6.0-x64.bin

# fix its perms
chmod 755 ./atlassian-jira-software-7.6.0-x64.bin

# create our varfile contents for the install
cat > ~/$RESPONSEFILE <<EOL
executeLauncherAction$Boolean=true
app.install.service$Boolean=true
sys.confirmedUpdateInstallationString=false
existingInstallationDir=/opt/JIRA Software
sys.languageId=en
sys.installationDir=/opt/atlassian/jira
EOL

# create our symlink in /var/atlassian to /opt/var/atlassian
# TODO
mkdir -p /opt/var/atlassian
ln -s /var/atlassian /opt/var/atlassian

# run it as root with the answer file
sudo ./atlassian-jira-software-7.6.0-x64.bin -q -varfile response.varfile

# drop our DB config into place
# CLI to retrieve the connection string for a DB?