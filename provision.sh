#!/bin/bash

DEBIAN_FRONTEND=noninteractive

CNTLM_FILE_NAME='cntlm.conf'

# params from 'args'
# CNTLM_USERNAME=''
# CNTLM_PASSWORD=''

# CNTLM_DOMAIN='Default'

# CNTLM_PROXY=''
# CNTLM_NOT_PROXY='localhost,127.0.0.*'
# CNTLM_LISTEM='0.0.0.0:3128'
CNTLM_AUTH='NTLMv2'

for i in "$@"
  do
  case $i in
    --user=*)
    CNTLM_USERNAME="${i#*=}"
    shift 
    ;;
    --password=*)
    CNTLM_PASSWORD="${i#*=}"
    shift
    ;;
    --domain=*)
    CNTLM_DOMAIN="${i#*=}"
    shift
    ;;
    --proxy=*)
    CNTLM_PROXY="${i#*=}"
    shift
    ;;
    --no-proxy=*)
    CNTLM_NOT_PROXY="${i#*=}"
    shift
    ;;
    --listen=*)
    CNTLM_LISTEM="${i#*=}"
    shift
    ;;
    *)
    ;;
  esac
done

if [ -z "$CNTLM_USERNAME" ]; then
  printf "\n<<< Failed, the 'user' parameter can't be empty\n"
  exit 1
fi
if [ -z "$CNTLM_PASSWORD" ]; then
  printf "\n<<< Failed, the 'password' parameter can't be empty\n"
  exit 1
fi
if [ -z "$CNTLM_DOMAIN" ]; then
  printf "\n<<< Failed, the 'domain' parameter can't be empty\n"
  exit 1
fi
if [ -z "$CNTLM_PROXY" ]; then
  printf "\n<<< Failed, the 'proxy' parameter can't be empty\n"
  exit 1
fi
if [ -z "$CNTLM_NOT_PROXY" ]; then
  printf "\n<<< Failed, the 'no-proxy' parameter can't be empty\n"
  exit 1
fi
if [ -z "$CNTLM_LISTEM" ]; then
  printf "\n<<< Failed, the 'listen' parameter can't be empty\n"
  exit 1
fi

# Stop cntlm
sudo systemctl stop cntlm

printf "\n>>> cntlm config:\n"
printf "\n*****************************************\n"

echo "Username $CNTLM_USERNAME" | tee $CNTLM_FILE_NAME
echo "Domain $CNTLM_DOMAIN" | tee -a $CNTLM_FILE_NAME

echo "$CNTLM_PASSWORD" | cntlm -H -u $CNTLM_USERNAME -d $CNTLM_DOMAIN | sed 's/Password://g' | tee -a $CNTLM_FILE_NAME

echo "Proxy $CNTLM_PROXY" | tee -a $CNTLM_FILE_NAME

echo "NoProxy $CNTLM_NOT_PROXY" | tee -a $CNTLM_FILE_NAME

echo "Listen $CNTLM_LISTEM" | tee -a $CNTLM_FILE_NAME

echo "Auth $CNTLM_AUTH" | tee -a $CNTLM_FILE_NAME

printf "\n*****************************************\n"

printf "\n>>> move $CNTLM_FILE_NAME to /etc/ and start cntlm... \n"
# add config file
sudo mv $CNTLM_FILE_NAME /etc/

# Star cntlm
sudo systemctl start cntlm

# print status
printf "\n>>> systemctl cntlm status:\n"
sudo systemctl status cntlm

echo "y" | sudo ufw enable
sudo ufw allow 3128/tcp
sudo ufw allow ssh

printf "\n>>> setup done!\n"
