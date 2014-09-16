############################################################
# Dockerfile to build an rspec-puppet container image
# Based on Centos7
###########################################################
FROM centos:centos7
MAINTAINER Greg Swift

# Update the base system
RUN yum update -y

# Install base packages to enable the workflow
RUN yum install -y rubygems git

# never install a ruby gem docs
RUN echo "gem: --no-rdoc --no-ri" >> /etc/gemrc

# Install the relevant gems
RUN gem install puppet rspec rspec-puppet puppetlabs_spec_helper puppet-lint rspec-puppet-utils rspec-puppet-augeas

# Setup a directory to load a module for test
VOLUME /module

# Define our working dir
WORKDIR /module

# Our default command
CMD rake spec