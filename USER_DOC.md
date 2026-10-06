# Inception - User Documentation

## Provided Services

This project provide a Wordpress service connected to a MariaDB server, and powered by Nginx.

## Start and Stop

To start the containers run
```Shell
make start
```

To stop them run
```Shell
make stop
```

And to restart them run
```Shell
make restart
```

## Manage Credentials

You can manage credentials in the ``srcs/.env`` file.

## Access the Wordpress website

To access the Wordpress website, you have to go to the domain name you define in ``.env``.

And to access  the administration panel you have to add ``/wp-admin`` to the URL and then login.

## Check the services are running

To check that the services are running run ``make stats`` and then you will see the containers stats.
