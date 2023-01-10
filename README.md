# RTSP Stream Recorder

This is a Docker and Docker Compose based solution for recording 5 RTSP streams using FFmpeg and Bash scripts. It provides the following functionality:

## Recording

- Record each stream as 10 minutes clips

## Merging

- At the end of the day, the clips will be merged into one 24 hour video

## Timelapse

- Create a timelapse video of the past day's footage

## Disk Space Management

- Cleanup old recorded videos if disk space is running low

## Getting Started

1. Make sure you have [Docker](https://www.docker.com/) and [Docker Compose](https://docs.docker.com/compose/) installed.
2. Update the RTSP stream URLs in the `docker-compose.yml` configuration file.
3. Run `docker-compose up -d` to start the recording and merging containers.
4. The recorded videos will be saved in the `output` directory.

## Images

- recorder: container that records the RTSP streams
- merger: container that runs a cronjob at the end of the day to merge the clips and create a timelapse video

## Troubleshooting

- If you encounter any issues while running the containers, you can check the logs by running `docker logs [container-name]`.
- If you continue to have trouble, please open an issue on the project's Github page.

## Contribute

If you want to contribute to this project, you can create a fork and send a pull request.

## License

This project is licensed under the [MIT License](https://opensource.org/licenses/MIT).
