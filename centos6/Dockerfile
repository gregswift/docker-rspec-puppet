############################################################
# Dockerfile to build an rspec-puppet container image
# Based on Centos6
###########################################################
FROM centos:centos6
MAINTAINER Greg Swift "gregswift@gmail.com"

# Update the base system and install main packages, then clean up
RUN printf "update \n install rubygems git ruby-devel libxml2-devel libxslt-devel \n run" | \
    yum shell --assumeyes && \
    yum clean all

# Configure to ever install a ruby gem docs then
# Install the relevant gems and cleanup after
RUN printf "gem: --no-rdoc --no-ri" >> /etc/gemrc && \
    gem install \
      puppet \
      rspec \
      rspec-puppet \
      rspec-puppet-augeas \
      rspec-puppet-facts \
      rspec-puppet-utils \
      puppetlabs_spec_helper \
      puppet-lint \
      bundler && \
    rm -rf /.gem

# Setup a directory to load a module for test
VOLUME /module

# Define our working dir
WORKDIR /module

# Our default command
CMD rake spec