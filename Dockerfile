FROM ubuntu:latest

MAINTAINER Kenneth Daily <kenneth.daily@sagebase.org>
LABEL base_image="ubuntu:latest"
LABEL about.summary="Docker image for template dockstore tool"
LABEL about.license="SPDX:MIT"

COPY VERSION /
COPY SOFTWARE_VERSION /
