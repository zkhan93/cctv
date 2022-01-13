FROM jrottenberg/ffmpeg
COPY record.sh /app/record.sh

ENV TIMEOUT_BUFFER 120
ENV LOG_LEVEL error

ENTRYPOINT ["/app/record.sh"]
