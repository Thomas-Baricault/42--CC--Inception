# Inception - Developer Documentation

## Setup

Make has to be installed on your operating system. If is not, run
```Shell
apt install make
```

Docker as to be installed, follow the instructions on the Docker documentation to do this

<https://docs.docker.com/engine/install>

Then, created the ``srcs/.env`` file using ``srcs/.env.example`` and enter your own key values.

Finally just run ``make`` to launch the project.

## Manage Containers

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

## Data

Data are stored in ``/home/${USER}/data/wordpress`` and ``/home/${USER}/data/mariadb``.

They persist even after the containers are restarted.
