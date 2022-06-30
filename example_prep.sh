!/usr/bin/env bash

#Need to check OS / Platform
osName=`uname -s`
case $osName in
  Linux*)   export machine="Linux" ;;
  Darwin*)  export machine="Mac" ;;
  *)        export machine="UNKNOWN:$osName" ;;
esac

echo $machine

if [[ "$machine" == "Mac" ]]; then
  echo "OSX Detected, need to Install / Update Brew and jq..."
  #Need to update brew and make sure jq is installed to process json
  echo "updating & upgrading brew..."
  brew update || brew update
  brew upgrade

  if brew ls --versions jq > /dev/null; then
    # The package is installed
    echo "jq installed proceeding..."
  else
    echo "installing jq..."
    brew install jq
  fi
elif [[ "$machine" == "Linux" ]]; then
  if [ -f /etc/redhat-release ]; then
    yum -y update
    yum -y install jq
  fi
  if [ -f /etc/lsb-release ]; then
    sudo apt-get --assume-yes update
    sudo apt-get --assume-yes install jq curl
  fi
fi

export VOLT_API_P12_FILE=/creds/.api-creds.p12
export VES_P12_PASSWORD=12345678
export GCP_PROJECT=project_name
export GCP_ROLE_ID=xcs_gcp_vpc_role
export GCP_ACCOUNT_ID=xcs-gcp-vpc-spn

# Download Role Def
# Based on https://gitlab.com/volterra.io/cloud-credential-templates/-/tree/master/gcp
curl https://gitlab.com/volterra.io/cloud-credential-templates/-/raw/master/gcp/volterra_gcp_vpc_role.yaml?inline=false --output volterra_gcp_vpc_role.yaml
#Create GCP Role
gcloud iam roles create $GCP_ROLE_ID --project=$GCP_PROJECT --file=volterra_gcp_vpc_role.yaml
# Create GCP Service Account
gcloud iam service-accounts create $GCP_ACCOUNT_ID  --display-name=$GCP_ACCOUNT_ID

export GCP_SVC_EMAIL=`gcloud iam service-accounts list | grep $GCP_ACCOUNT_ID | awk '{print $2}'`

gcloud projects add-iam-policy-binding $GCP_PROJECT --member='serviceAccount:'$GCP_SVC_EMAIL'' --role=projects/$GCP_PROJECT/roles/$GCP_ROLE_ID

gcloud iam service-accounts keys create --iam-account $GCP_SVC_EMAIL key.json