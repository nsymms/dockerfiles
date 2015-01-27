Docker container that creates a SMB share.

## Running

```
docker run -d -p 445:445 \
  -v /mnt/data:/share/data \
  -v /mnt/backups:/share/backups \
  --name <container name> zaraki673/docker-samba \
  -u "alice:abc123" \
  -u "bob:secret" \
  -u "guest:guest" \
  -s "Backup directory:/share/backups:rw:alice,bob" \
  -s "Alice (private):/share/data/alice:rw:alice" \
  -s "Bob (private):/share/data/bob:rw:bob" \
  -s "Documents (readonly):/share/data/documents:ro:-public"
```

This example will bind `smbd` to docker host ip address
and mount two directories on docker host to container.
Three users will be created and given various access to four shares.
Note that specifying user "-public" will allow anonymous connections to a share.

## Connecting

To keep things simple, TCP port 445 is the only exposed port.
