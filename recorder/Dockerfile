FROM ubuntu:latest

ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=Asia/Kolkata
RUN apt-get update \
 && apt-get install -yq software-properties-common tzdata
RUN add-apt-repository ppa:jonathonf/ffmpeg-4
RUN apt-get install ffmpeg -y

#FROM linuxserver/ffmpeg:version-4.4-cli
#RUN apt-get update && apt-get install --no-install-recommends tzdata -yq

COPY record.sh /app/record.sh
ENV TIMEOUT_BUFFER 30
ENV LOG_LEVEL error

ENTRYPOINT ["/app/record.sh"]
