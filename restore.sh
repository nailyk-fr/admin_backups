#!/system/xbin/bash

# script to restore data made on another device with: 
# tar cjf /tmp/backup.tar.gz /data/data/com.fsck.k9 /data/data/org.smssecure.smssecure/ /data/data/org.mozilla.fennec_fdroid /data/data/org.schabi.newpipe /data/data/com.github.dfa.diaspora_android /data/data/com.owncloud.android /data/data/im.vector.alpha /data/data/name.boyle.chris.sgtpuzzles

BKP_FILE=$1
TRGT_APP=$2

if [ -z "${BKP_FILE}" ]; then
        echo "You NEED to provide a backup file ;)"
		echo "Usage: "
		echo "       $0 \<backupfile.tar.gz\> \[path to restore\]"
		echo .
        exit 1
fi

if [ ! -f ${BKP_FILE} ]; then
    echo "File not found!"
        exit 2
fi

if [ -z "${TRGT_APP}" ]; then
	echo "Target app (2nd arg) not provided. Using default app list"
	DIR=( /data/data/com.fsck.k9 /data/data/org.smssecure.smssecure/ /data/data/org.mozilla.fennec_fdroid /data/data/org.schabi.newpipe /data/data/com.github.dfa.diaspora_android /data/data/com.owncloud.android /data/data/im.vector.alpha /data/data/name.boyle.chris.sgtpuzzles )
else
	DIR=${TRGT_APP}
fi

for app in "${DIR[@]}" ; do

		if [ ! -d ${app} ]; then
			echo "App ${app} not found!!"
			echo "Giving up on it!"
			continue
		fi

        USER=$(stat -c '%U' ${app})
        GROUP=$(stat -c '%G' ${app})

        echo " "
        echo " "
        echo "------- Gonna restore datas for ${USER}:${GROUP} on ${app}!"

	echo "Press enter to continue"
        read

        # Tar do not keep first slash. Remove it from folder name
        TAR_DIR=$(echo ${app}| sed "s,^/,,")

        echo "extracting datas!"
        tar xvf ${BKP_FILE} ${TAR_DIR}
        STATUS=$?

		if [ ${STATUS} -ne 0 ]; then
			echo "error $STATUS while extracting data!" >&2
			echo "........... giving up on ${app}! ..........."
			continue
		fi

        echo "restoring owner chip!"
        chown -RPv ${USER}:${GROUP} ${app}
		STATUS=$?
		if [ ${STATUS} -ne 0 ]; then
			echo "error $STATUS while changing ownerchip!" >&2
			echo "........... giving up on ${app}! ..........."
			continue
		fi

        echo "restoring selinux context!"
        restorecon -Rv ${app}
		STATUS=$?
		if [ ${STATUS} -ne 0 ]; then
			echo "error $STATUS while restor SElinux context!" >&2
			echo "........... giving up on ${app}! ..........."
			continue
		fi


        echo "------- ${app} over! -------"
done


echo "done!"

