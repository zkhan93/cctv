FROM ubuntu:latest

ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update \
    && apt-get install -yq software-properties-common tzdata cron curl
ENV TZ=Asia/Kolkata
RUN add-apt-repository ppa:jonathonf/ffmpeg-4
RUN apt-get install ffmpeg -y


COPY *.sh /app/

RUN chmod 0744 /app/*.sh

COPY cronfile /etc/cron.d/cronfile
RUN chmod 0644 /etc/cron.d/cronfile
RUN touch /var/log/cron.log

RUN crontab /etc/cron.d/cronfile

ENTRYPOINT ["/app/entrypoint.sh"]
