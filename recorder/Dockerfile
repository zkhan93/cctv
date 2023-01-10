FROM ubuntu:latest

ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=Asia/Kolkata
RUN apt-get update \
    && apt-get install -yq software-properties-common tzdata
RUN add-apt-repository ppa:jonathonf/ffmpeg-4
RUN apt-get install ffmpeg -y

COPY record.sh /app/record.sh
ENV TIMEOUT_BUFFER 30
ENV LOG_LEVEL error

ENTRYPOINT ["/app/record.sh"]
