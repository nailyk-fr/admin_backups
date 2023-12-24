#!/bin/bash

BASE_URL='https://download.osmand.net/download?standard=yes&file='
INDEX="https://download.osmand.net/list.php"
#COUNTRY_LIST="Austria Czech-republic Denmark France Germany Belgium Italy Netherlands Sweden Switzerland Luxembourg World_basemap fr_0.voice en_0.voice ru_0.voice be_0.voice"
COUNTRY_LIST="France Germany Belgium Luxembourg World_basemap fr_0.voice en_0.voice ru_0.voice be_0.voice"
TMPDIR="$(mktemp -d)"
OLD_DIR="$(pwd)"
OUTPUTDIR="${OLD_DIR}./maps"

echo "----Starting with counrty list : ${COUNTRY_LIST}"


## Go to temp dir
cd ${TMPDIR}

# download index
wget ${INDEX} --output-document=index.html


T_FILE_LIST=""

## Retrieve each file for each country
for country in ${COUNTRY_LIST}
do
	for file in $(grep href index.html | cut -d '"' -f2 | grep ${country} | awk 'BEGIN{FS="="} {print $NF}')
	do
		T_FILE_LIST="${T_FILE_LIST} ${file}"
	done
done

mkdir -p ${OUTPUTDIR} || true

## download
for line in ${T_FILE_LIST}
do
	wget --continue "${BASE_URL}${line}" --output-document=${OUTPUTDIR}/${line}
done


echo "Download finished in ${OUTPUTDIR}"


## restore back env
cd ${OLD_DIR}
rm -rf ${TMPDIR}
