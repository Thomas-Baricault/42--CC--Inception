*This project has been created as part of the 42 curriculum by tbaricau*

# Inception

## Description

The goal of this project is to create multiple docker images from scratch, and then run containers from those images to create a wordpress environment.

## Instructions

Create your own ``srcs/.env`` from ``srcs/.env.example``.

Bring up the containers
```Shell
make up
```

Bring down the containers
```Shell
make down
```

Bring down and then bring up the containers
```Shell
make du
```

Start the containers
```Shell
make start
```

Stop the containers
```Shell
make stop
```

Restart the containers
```Shell
make restart
```

Clean images and volumes
```Shell
make clean
```

Clean and bring up the containers
```Shell
make re
```

When the containers are up, you can go to ``https://<login>.42.fr`` to see the wordpress site.

## Project description

In this project, we have three services each running on a Docker container.

In the ``srcs/requirements`` folder, there is a folder for each service, with a Dockerfile to create the image and a setup file used as entrypoint.

You can create the ``srcs/.env`` file from ``srcs/.env.example`` to setup environment variable used by the containers.

### Virtual Machines vs Docker

Virtual machines allow to run any entire environment system on any machine. But Docker allow to run any application on any environment system. Docker is lighter than virtual machines because it doesn't copy the entire system, so it's also faster and need less ressources.

### Secrets vs Environment Variables

Environment variables are used to define configuration values without modifying the application code. While secrets are used to store sensible data like API token or credentials.

### Docker Network vs Host Network

A Docker network is isolated from the host network, it's therefore more secure and you can specify which port to expose.

### Docker Volumes vs Bind Mounts

A bind mount is a direct link between the Docker container and the host file system. While Docker volumes is managed by Docker, it's more secure because Docker control the access to it and it's also more performant.

## Resources

Docker documentation:

<https://docs.docker.com>

Docker Compose documentation:

<https://docs.docker.com/compose/>

How to install docker on a debian:

<https://docs.docker.com/engine/install/debian/>

Example of working inception:

<https://github.com/Forstman1/inception-42>

AI was used to get example for Dockerfile, and to resolve specific error cases like what is wrong in config files.
