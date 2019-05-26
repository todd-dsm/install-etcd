#!/usr/bin/env bash

function pMsg() {
    theMessage="$1"
    printf '\n%s\n' "$theMessage"
}

pMsg "Setting to pre-existing project..."
gcloud config set project 'pac-test-app-landingpad'
#gcloud config set project 'tf-kubes'


pMsg "Setting project region and zone to Los Angeles..."
region='us-west2'
zone="${region}-a"
gcloud config set compute/region "$region"
gcloud config set compute/zone "$zone"

emailID="$(gcloud auth list --filter=status:ACTIVE --format="value(account)")"
pMsg "Setting project user: $emailID"
gcloud config set account "$emailID"


pMsg "Enabling project-specific APIs..."
gcloud services enable container.googleapis.com


pMsg "The new project parameters:"
gcloud config configurations list

