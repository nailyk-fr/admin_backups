#!/system/xbin/bash

# script to restore data made on another device with: 
# tar cjf /tmp/backup.tar.gz /data/data/com.fsck.k9 /data/data/org.smssecure.smssecure/ /data/data/org.mozilla.fennec_fdroid /data/data/org.schabi.newpipe /data/data/com.github.dfa.diaspora_android /data/data/com.owncloud.android /data/data/im.vector.alpha /data/data/name.boyle.chris.sgtpuzzles

BKP_FILE=$1

if [ -z "${BKP_FILE}" ]; then
        echo "You NEED to provide a backup file ;)"
        exit 1
fi

if [ ! -f ${BKP_FILE} ]; then
    echo "File not found!"
        exit 2
fi


#DIR=( /data/data/com.fsck.k9 /data/data/org.smssecure.smssecure )
DIR=( /data/data/com.fsck.k9 /data/data/org.smssecure.smssecure/ /data/data/org.mozilla.fennec_fdroid /data/data/org.schabi.newpipe /data/data/com.github.dfa.diaspora_android /data/data/com.owncloud.android /data/data/im.vector.alpha /data/data/name.boyle.chris.sgtpuzzles )

for app in "${DIR[@]}" ; do

		if [ ! -f ${app} ]; then
			echo "App ${app} not found!!"
			echo "Giving up on it!"
			continue
		fi

        USER=$(stat -c '%U' ${app})
        GROUP=$(stat -c '%G' ${app})

        echo " "
        echo " "
        echo "------- Gonna restore datas for ${USER}:${GROUP} on ${app}!"

        read -p "Press enter to continue"

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

        echo "restoring selinux context!"
        restorecon -Rnv ${app}

        echo "------- ${app} over! -------"
done


echo "done!"

