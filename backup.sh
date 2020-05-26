#!/bin/sh


   

for app in /data/data/com.fsck.k9 \
  /data/data/org.smssecure.smssecure \
  /data/data/org.mozilla.fennec_fdroid \
  /data/data/org.schabi.newpipe \
  /data/data/com.github.dfa.diaspora_android \
  /data/data/com.owncloud.android \
  /data/data/im.vector.alpha \
  /data/data/name.boyle.chris.sgtpuzzles \
  /data/data/com.bil.android \
  /data/data/com.samsung.android.app.watchmanager \
  /data/data/com.nextcloud.client \
  /data/data/org.telegram.messenger \
  /data/data/de.arnowelzel.android.periodical
do
if [[ -d ${app} ]]
then
  tar cjf /sdcard/backup_$(basename ${app})_$(date +"%Y-%m-%d").tar.gz ${app}
else
  echo "WARNING ! ${app} not found ! "
fi
done


