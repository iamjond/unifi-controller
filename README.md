# unifi-controller

## Run the container

`docker run -d --name unifi-controller -p 8081:8081 -p 8080:8080 -p 8443:8443 -p 8880:8880 -p 8843:8843 -v /opt/docker-data/unifi/unifi-var:/opt/unifi-var -v /dev/urandom:/dev/random iamjond/unifi-controller`

## Versioning

The image is vesioned, along with tag aliases for `latest`,  as well as the Unifi Controller version:

| Image Version | Tag | Description |
----------------|-----|--------------
1.0 |`latest`| Gets the latest image
1.0 |`unifi-5.6.22` | Get the image by Unifi Controller version

## A container with 2 processes?

Best practise would normally dictate that a container should contain only a single process.  The Unifi Controller start script does start a MongoDB process, and I've left this as-is to simplify the deployment, and maintain all the data and configuration in a central location.

## Ports and SSL

My prefererred mode of operation is to manage all my containers behind a single reverse-proxy.  The reverse proxy handles virtual host mappings as well as SSL termination.

In my own setup I am using nginx with LetsEncrypt certificates.  This works well with a roll-your-own setup, as well as Synology NAS.


