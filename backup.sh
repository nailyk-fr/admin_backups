#!/bin/sh


   

for app in /data/data/com.fsck.k9 \
  /data/data/org.smssecure.smssecure \
  /data/data/org.mozilla.fennec_fdroid \
  /data/data/org.schabi.newpipe \
  /data/data/im.vector.alpha \
  /data/data/name.boyle.chris.sgtpuzzles \
  /data/data/de.arnowelzel.android.periodical \
  /data/data/org.liberty.android.freeotpplus \
  /data/data/com.android.deskclock \
  /data/data/com.keylesspalace.tusky.test \
  /data/data/com.huami.watch.hmwatchmanager \
  /data/data/org.schabi.newpipe \
  /data/data/org.openhab.habdroid \
  /data/data/lacaveauxenigmes.game.com \
  /data/data/dev.ukanth.ufirewall
do
if [[ -d ${app} ]]
then
  echo "Backup up ${app}... "
  tar cjf /sdcard/backup_$(basename ${app})_$(date +"%Y-%m-%d").tar.gz ${app}
else
  echo "WARNING ! ${app} not found ! "
fi
done


