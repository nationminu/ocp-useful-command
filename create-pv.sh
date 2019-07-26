#/usr/bin/env/bash

NFS_SERVER=nfs-server.default.svc

for volume in pv{1..50} ; do

echo "{
  \"apiVersion\": \"v1\",
  \"kind\": \"PersistentVolume\",
  \"metadata\": {
    \"name\": \"${volume}-volume\"
  },
  \"spec\": {
    \"capacity\": {
        \"storage\": \"1Gi\"
    },
    \"accessModes\": [ \"ReadWriteOnce\" ],
    \"nfs\": {
        \"path\": \"/srv/nfs/user-vols/${volume}\",
        \"server\": \"${NFS_SERVER}\"
    },
    \"persistentVolumeReclaimPolicy\": \"Recycle\"
  }
}" \
| oc create -f - ;
# | oc delete -f - ;

done;

