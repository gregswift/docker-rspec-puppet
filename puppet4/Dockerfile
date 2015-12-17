############################################################
# Dockerfile to build an rspec-puppet container image
# Based on fedora:21 because 22/latest uses too new of ruby
###########################################################
FROM fedora:21
MAINTAINER Greg Swift "gregswift@gmail.com"

# Yum or dnf ? depends on fedora version. 22+ is dnf
ENV pkgmgr yum

# Set working dir as variable
ENV module_dir /module

# Update the base system and install main packages, then clean up
RUN ${pkgmgr} -y update && \
    ${pkgmgr} -y install rubygems ruby-devel rubygem-nokogiri \
                         libxml2-devel libxslt-devel augeas-devel \
                         git gcc gcc-c++ make tar && \
    ${pkgmgr} clean all

# Add Gemfile
ADD Gemfile /

# Configure to ever install a ruby gem docs then
# Install the relevant gems and cleanup after
RUN printf "gem: --no-rdoc --no-ri" >> /etc/gemrc && \
    gem install json -v '1.8.3' && \
    gem install bundler

# Set Puppet Version
# TODO: Eventually we wont need separate files for this
# https://github.com/docker/docker/issues/14634
ENV puppetversion "~> 4.2"

# Now do the bundle install. I Split this off to minimize differences between 3 and 4
RUN PUPPET_GEM_VERSION=${puppetversion} bundler install --clean --system --gemfile /Gemfile

# Setup a directory to load a module for test
VOLUME ${module_dir}

# Define our working dir
WORKDIR ${module_dir}

# Our default command
CMD rm -rf Gemfile.lock && \
    bundle exec rake spec_clean && \
    bundle exec rake spec

# Atomic Metadata
LABEL RUN="docker run -it --rm -v \$(pwd):/module:z -v \${OPT1}:/ssh-agent:z -e SSH_AUTH_SOCK=/ssh-agent IMAGE"
