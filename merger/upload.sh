#/bin/bash
TITLE=$1
FILE=$2

PAYLOAD=$(cat <<EOF
{
  "local_file": "$FILE",
  "email": "$EMAIL", 
  "snippet": {
    "title": "$TITLE",
    "tags": [
      "timelapse"
    ],
    "categoryId": [
      "22"
    ]
  }
}
EOF
)

RES=$(curl -X 'POST' \
  'https://tb-yt-uploader.khancave.in/upload-local-to-youtube' \
  -H 'accept: application/json' \
  -H "access_token: $ACCESS_TOKEN" \
  -H 'Content-Type: application/json' \
  -d "$PAYLOAD" -s)
echo $RES
