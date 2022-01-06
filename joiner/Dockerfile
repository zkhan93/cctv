FROM jrottenberg/ffmpeg

RUN apt-get update && apt-get install cron -y

COPY merge.sh /app/merge.sh
RUN chmod 0744 /app/merge.sh

COPY cronfile /etc/cron.d/cronfile
RUN chmod 0644 /etc/cron.d/cronfile

RUN touch /var/log/cron.log

RUN crontab /etc/cron.d/cronfile

ENTRYPOINT ["cron", "-f"]
