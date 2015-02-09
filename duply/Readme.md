# A duply container

Runs duply, the frontend for duplicity.
More info on those two can be found in the duply project documentation [here](http://duply.net/wiki/index.php/Duply-documentation).

## Running it

There's no configuration file location specified, so by default it is the user's HOME directory. The easiest way to run the container is to override the HOME environment variable with your own HOME dir.

```
docker run -i -t -e HOME=/cache -v ~/duply-data:/cache \
        -v /Backups/Apps:/Backups/Apps:ro duply apps-bak bkp
```

If you want to override the default HOME dir locations, there ways to do so as noted on the duply and duplicity documentation. Normally, duply stores its profiles in $HOME/.duply, but will search /etc/duply for root user profiles. Duplicity (used by duply) normally stores its cache files in $HOME/.cache/duplicity. Here's an example of overriding those locations:

```
docker run -d -v /opt/duply-configs:/etc/duply \
        -v /opt/duplicity-cache:/duplicity-cache \
        -v /Backups/Apps:/Backups/Apps:ro \
        nsymms/duply apps-bak bkp --archive-dir=/duplicity-cache
```
