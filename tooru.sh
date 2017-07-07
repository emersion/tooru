#!/usr/bin/env bash

set -euf -o pipefail

url_host() {
	echo "$1" | cut -d'/' -f3
}

ytdl_check() {
	env url="$1" python << EOF
import os
from youtube_dl.extractor import get_info_extractor, gen_extractor_classes, _LAZY_LOADER

url = os.getenv('url')
for ie in gen_extractor_classes():
	if ie.ie_key() != "Generic" and ie.suitable(url):
		exit(0)
exit(1)
EOF
}

sources_file=sources
if [ "$#" -eq 1 ]; then
	sources_file="$1"
fi

if [ ! -f "$sources_file" ]; then
	echo "tooru: cannot find sources file \"$sources_file\"" >&2
	exit 1
fi

while read -r src; do
	url=$(echo "$src" | cut -f 1 -d ' ')
	options=($(echo "$src" | cut -f 2- -d ' '))

	echo "Archiving $url"
	if ytdl_check "$url"; then
		host=$(url_host "$url")
		youtube-dl -w -o "$host/%(playlist)s/%(id)s.%(ext)s" --add-metadata -i --download-archive "$host/ids" "${options[@]}" "$url" || true
	else
		wget -m "${options[@]}" "$url"
	fi
	echo ""
done < "$sources_file"
