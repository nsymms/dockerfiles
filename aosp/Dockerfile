#
# Adds oracle java 6 to Kyle Manna's great aosp container
#
# Note that it sets java 6 as the default.
# use "update-alternatives --config java" to switch.
#
FROM kylemanna/aosp

MAINTAINER Neal Symms <neal.symms@gmail.com>

RUN apt-get update && apt-get install -y software-properties-common && \
    add-apt-repository -y ppa:webupd8team/java && \
    echo oracle-java6-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && \
    apt-get update && apt-get install -y oracle-java6-installer && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /var/tmp/* /var/cache/oracle*

