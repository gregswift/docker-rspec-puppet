docker-rspec-puppet
===================

Docker images for running puppet module rspec tests

Tags
====
I've reworked things to provide tags based on the major version of puppet, rather than
on distributions.

  * puppet3
  * puppet4

The highest major version will always be associated with the _latest_ tag.

Usage
=====
The simplest docker run for this module is, which must be done from inside a puppet module.

    docker run -it --rm -v $(pwd):/module:z gregswift/rspec-puppet:latest

If your puppet module's fixtures include some git over ssh repositories you can do this

    docker run -it --rm -v $(pwd):/module:z -v ${SSH_AUTH_SOCK}:/ssh-agent:z -e SSH_AUTH_SOCK=/ssh-agent gregswift/rspec-puppet:latest

To run against a specific major version of puppet just replace :latest with :puppetX

Alternatively, this container includes atomic app compatible syntax for the SSH_AUTH_SOCK setup

    atomic run --name=test --opt1=${SSH_AUTH_SOCK} gregswift/rspec-puppet:latest

Building
========

Make is setup to handle the building, and by defaults builds both puppet3 and puppet4 targets

    make

If you want to build it in your namespace to push to the hub set DOCKER_USER

    DOCKER_USER=gregswift make

If docker needs to be called with sudo, ensure the sudo comes before DOCKER_USER

    sudo DOCKER_USER=gregswift make

You can call the targets directly as well

    make puppet3
    make puppet4

But to build them manually:

    docker build -t rspec-puppet:puppet3 puppet3/
    docker build -t rspec-puppet:puppet4 puppet4/

