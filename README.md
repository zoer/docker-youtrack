# YouTrack on Docker

This repository contains a Docker image of JetBrains
[YouTrack](http://www.jetbrains.com/youtrack).

* The Docker image is available at
[zoer/youtrack](https://registry.hub.docker.com/u/zoer/youtrack)
* The GitHub repository is available at
[zoer/docker-youtrack](https://github.com/zoer/docker-youtrack)

## Usage

First, pull the Docker image using the following command:

    docker pull zoer/youtrack

Next, create a container.

    docker run -d zoer/youtrack

YouTrack starts and listens on port 80 in the container. To map it to the host's
port 80, use the following command to create the container instead:

    docker run --name youtrack -p 8080:80 -d zoer/youtrack

### Additional settings

YouTrack stores its data and backups at ```/root/teamsysdata``` and
```/root/teamsysdata-backup``` in the container. If you wish to re-use data,
it is a good idea to set up a volume mapping for these two paths. For example:

    mkdir /var/lib/youtrack
    docker run --name youtrack \
      -v /var/lib/youtrack/teamsysdata:/root/teamsysdata \
      -v /var/lib/youtrack/teamsysdata-backup:/root/teamsysdata-backup \
      -p 8080:80 -d zoer/youtrack

### Restore from a backup

Extract the backup file to ```/var/lib/youtrack/teamsysdata```

    mkdir -p /var/lib/youtrack/teamsysdata
    cd /var/lib/youtrack/teamsysdata
    rm -rf *
    tar xvf ~/Youtrack_backup_file.tar.gz
    docker start youtrack
