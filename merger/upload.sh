#/bin/bash
CAMID=$1
DATE=$2
FILE=$3

if [ "$CAMID" == "cam1" ]; then
  LOCATION="Indian City"
else
  LOCATION="Indian Village"
fi

TITLE="[$CAMID] ${LOCATION} - ${DATE}"

DESCRIPTION="Live CCTV footage from ${LOCATION} captured on ${DATE}. Watch and stay updated with real-time events in the ${LOCATION}."


PAYLOAD=$(cat <<EOF
{
  "local_file": "$FILE",
  "email": "$EMAIL", 
  "snippet": {
    "title": "$TITLE",
    "description": "$DESCRIPTION",
    "tags": ["city", "village", "CCTV", "live feed", "security", "real-time", "monitoring"],
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
