# Base the name of the software on the spec file
REPO = rspec-puppet

ifneq ($(origin DOCKER_USER), undefined)
DOCKER_USER := ${DOCKER_USER}/
endif

# Since the targets puppet3 and puppet4 match directories
# we have to fool make
# https://stackoverflow.com/questions/3931741/why-does-make-think-the-target-is-up-to-date/3931814
.PHONY: all puppet3 puppet4

# Variables for clean build directory tree under repository
all: puppet3 puppet4

puppet3:
	docker build -t ${DOCKER_USER}${REPO}:puppet3 puppet3/

puppet4:
	docker build -t ${DOCKER_USER}${REPO}:puppet4 puppet4/

publish:
	docker push ${DOCKER_USER}${REPO}:puppet3
	docker push ${DOCKER_USER}${REPO}:puppet4
