![License MIT](https://img.shields.io/badge/license-MIT-blue.svg)

Based off of https://github.com/jwilder/nginx-proxy

# Overview

For development only: this haproxy image runs docker-gen and generates the haproxy configuration based on a template. Haproxy is reloaded abruptly (via pkill) as I could not figure out a way to get it to reload gracefully, but since this only really happens when starting/stopping services **in development**, it's not a big deal.

## Configuration Template

A virtual host is created for each docker-compose service as long as it's marked with a particular label -- by default, this label is `backend`, but can be specified with the `label` environment variable passed to the proxy container.

The virtual host routing is done using a very flexible `hdr_beg(host) -i {name}.` acl in haproxy. This means you can set up a wildcard DNS entry: for example, `*.dev.mycompany.com` (resolving to 127.0.0.1) - and access all your docker-compose started services via `{service}.dev.mycompany.com`.

# Demo

There is a Vagrantfile in this repo that provisions with Docker, and uses the docker-compose file to build this image and start a simple hello service. It uses a private network with a specific IP, so you can `vagrant up` and then `curl hello.169.0.13.37.xip.io` >> you get 'hello' service in the compose file! (Private networks are generally better than port forwarding because VirtualBox NAT will shit the bed on you at some point)

# Advanced

What sets this apart from other 'automatic backend' containers is its support for a development instance of a service taking over handling requests for a given service. Two things are required - an IP address of the development machine, and a port that the development instance of the service will be running on at said IP address. Again the Vagrantfile and the docker-compose file have examples of this - the dev_ip is passed in from Vagrant, which gives an address routable from the guest machine "out" to the host machine. The dev_hello variable specifies which port hello would run on the host machine in development mode.

The next 'step' from here is to have inter-service communication also use a wildcard hostname of the gateway and to 'alias' that in the compose file.  This is demonstrated in the docker-compose.yml as well.

If you do all these things, you can start up a development instance of a service and make changes, and other services running in Docker will speak to the development instance of the service until you kill that process - at which point communication routes right back to the 'docker' instance.
