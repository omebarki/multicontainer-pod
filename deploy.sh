#!/usr/bin/env bash

typeset SCRIPT_DIR=$(dirname "${BASH_SOURCE[0]}")
function get_resource(){
    typeset rtype=$1
    typseset rname=$2
    oc get ${rtype} ${rname} -o name --ignore-not-found=true
}

if [[ -z "$(get_resource cm multicontainer-server-config)" ]];
then
    oc create -f ${SCRIPT_DIR}/multicontainer-server/target/openshift/configMap.yml
fi

if [[ -z "$(get_resource cm multicontainer-client-config)" ]];
then
    oc create -f ${SCRIPT_DIR}/multicontainer-client/target/openshift/configMap.yml
fi