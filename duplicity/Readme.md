# A duplicity container

Runs duplicity.
More info can be found in the documentation on the duplicity project homepage
[here](http://http://duplicity.nongnu.org/docs.html).

## Running it

There's no configuration file location specified; by default it is the user's HOME
directory. The easiest way to run the container is to override the HOME environment
variable with your own HOME dir.

```
docker run -i -t -e HOME=/Backups/config \
        -v /Backups/Apps:/Backups/Apps:ro \
	nsymms/duplicity /Backups/Apps onedrive://Backups/Apps
```
The --allow-source-mismatch option is appended to all operations, since we're running
in a container. Otherwise duplicity would think we've switched hosts at each invocation.

If you want to override the default HOME dir locations, there ways to do so as noted
in the duplicity documentation. Normally, duplicity stores its cache files in
$HOME/.cache/duplicity. Also, if you're using gpg keys it will look for them in
$HOME/.gnupg. Again, the easiest solution is to simply supply a new HOME. But if you're
the adventurous type, you can override the default locations like this:
```
docker run -d -v /opt/duplicity-cache:/duplicity-cache \
        -v /Backups/Apps:/Backups/Apps:ro \
        nsymms/duplicity /Backups/Apps onedrive://Backups/Apps \
	--archive-dir=/duplicity-cache --encrypt-key ABCDEF09 --encrypt-ecret-keyring /my/key/file
```

## Endpoint Setup
Note that some endpoints require special setup. That is, the first time you use duply
to access these endpoints you must do so interactively.
In these cases the endpoint providers will most likely store things (access keys, etc.) into
the $HOME directory. If this is the case, there may be ways to override the storage location.
You'll have to check the duplicity documentation for your particular endpoint adapter.

An example is Microsoft's OneDrive. The first time you run duply with a destination of
onedrive://xxx, duply will ask you to go to a URL, login to MS Live, and paste back the
resulting code so that it can store the access key for future use.
