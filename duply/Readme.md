# A duply container

Runs duply, the frontend for duplicity.
More info on those two can be found here:

## Running it

There's no special configuration file location specified, so by default it is
the user's HOME directory. Therefore the easiest way to do this is to override
the HOME environment variable with your own HOME dir or some other location where
your gnupg keys and duply config infos are kept.

docker run -i -t -e HOME=/cache -v ~/duply-data:/cache \
        -v /home/neal/Backups/Apps:/home/neal/Backups/Apps:ro \
        duply apps-bak bkp

