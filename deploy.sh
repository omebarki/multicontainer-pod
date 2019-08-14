#!/usr/bin/env bash

typeset SCRIPT_DIR=$(dirname "${BASH_SOURCE[0]}")
function get_resource(){
    typeset rtype=$1
    typeset rname=$2
    oc get ${rtype} ${rname} -o name --ignore-not-found=true
}

#server
oc import-image multicontainer-server:0.0.1-SNAPSHOT --from=docker.io/tadartiw/multicontainer-server:0.0.1-SNAPSHOT --confirm --insecure=true

if [[ -n "$(get_resource cm multicontainer-server-config)" ]];
then
   oc delete cm  multicontainer-server-config
fi
oc create -f ${SCRIPT_DIR}/multicontainer-server/target/openshift/configMap.yml


#client
oc import-image multicontainer-client:0.0.1-SNAPSHOT --from=docker.io/tadartiw/multicontainer-client:0.0.1-SNAPSHOT --confirm --insecure=true
if [[ -n "$(get_resource cm multicontainer-client-config)" ]];
then
    oc delete cm  multicontainer-client-config
fi
oc create -f ${SCRIPT_DIR}/multicontainer-client/target/openshift/configMap.yml

if [[ -n "$(get_resource svc multicontainer-client)" ]];
then
    oc delete svc  multicontainer-client
fi
oc create -f ${SCRIPT_DIR}/multicontainer-client/target/openshift/service.yml

if [[ -n "$(get_resource route multicontainer-client-route)" ]];
then
    oc delete route  multicontainer-client-route
fi
oc create -f ${SCRIPT_DIR}/multicontainer-client/target/openshift/route.yml

#DC
if [[ -n "$(get_resource dc multicontainer-pod)" ]];
then
    oc delete dc  multicontainer-pod
fi
oc create -f ${SCRIPT_DIR}/target/openshift/deploymentConfig.yml