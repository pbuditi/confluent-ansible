#!/bin/bash

#source /etc/profile.d/maven.sh

BASE_DIR=$(pwd)
PACKAGE_BASE_DIR="$(pwd)/target"
DEPLOY_ENV=$1
VAULT_PASS=$2
KEY_PATH=$3

rm -rf $BASE_DIR/rio-ansible-vault.tmp || true
echo $VAULT_PASS > $BASE_DIR/rio-ansible-vault.tmp

export ANSIBLE_HOST_KEY_CHECKING=False

#mvn -Pjar clean package
export PIP_INDEX_URL=https://nexuscimgmt.sgp.dbs.com:8443/nexus/repository/pypi-all/simple/
#rm -rf ~/venv

if [ ! -d ~/venv ]
then
  python -m easy_install pip
  python -m pip install --index-url https://nexuscimgmt.sgp.dbs.com:8443/nexus/repository/pypi-all/simple/ virtualenv
  python -m virtualenv ~/venv
fi

source ~/venv/bin/activate

export CURL_CA_BUNDLE=
export REQUESTS_CA_BUNDLE=

export PYTHONUSERBASE=~/venv
export VIRTUALENVWRAPPER_PYTHON=/home/pdcifadm/venv/bin/python

pip install --trusted-host nexuscimgmt.sgp.dbs.com:8443 --index-url https://nexuscimgmt.sgp.dbs.com:8443/nexus/repository/pypi-all/simple/ ansible

#EXTRA_PARAMS="--user=$DEPLOY_USER --become-method=su --connection=paramiko -e ansible_connection=paramiko -e host_key_checking=False -e deploy_host=$DEPLOY_ENV -e ansible_become_pass=$CRED_BECOME_PASS -e ansible_ssh_pass=$DEPLOY_USER_PASS -e ansible_password=$DEPLOY_USER_PASS -e jar_file=$API_FULL_NAME"


EXTRA_PARAMS="-e host_key_checking=False --vault-password-file=$BASE_DIR/rio-ansible-vault.tmp"

ansible-playbook -i $BASE_DIR/inventory/$DEPLOY_ENV/hosts.yml $EXTRA_PARAMS $BASE_DIR/all.yml --private-key=$KEY_PATH

rm -rf $BASE_DIR/rio-ansible-vault.tmp || true

deactivate
