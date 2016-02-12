FROM fedora
MAINTAINER http://fedoraproject.org/wiki/Cloud
ENV container docker
RUN dnf -y update && dnf -y install rsyslog && dnf clean all

LABEL INSTALL="docker run --rm --privileged -v /:/host \
-e HOST=/host -e IMAGE=IMAGE -e NAME=NAME \
IMAGE /bin/install.sh"

LABEL UNINSTALL="docker run --rm --privileged -v /:/host \
-e HOST=/host -e IMAGE=IMAGE -e NAME=NAME \
IMAGE /bin/uninstall.sh"

LABEL RUN="docker run -d --privileged --name NAME \
--net=host --pid=host \
-v /etc/pki/rsyslog:/etc/pki/rsyslog \
-v /etc/rsyslog.conf:/etc/rsyslog.conf \
-v /etc/sysconfig/rsyslog:/etc/sysconfig/rsyslog \
-v /etc/rsyslog.d:/etc/rsyslog.d \
-v /var/log:/var/log \
-v /var/lib/rsyslog:/var/lib/rsyslog \
-v /run:/run \
-v /etc/machine-id:/etc/machine-id \
-v /etc/localtime:/etc/localtime \
-e IMAGE=IMAGE -e NAME=NAME \
--restart=always IMAGE /bin/rsyslog.sh"

ADD install.sh /bin/install.sh
ADD rsyslog.sh /bin/rsyslog.sh
ADD uninstall.sh /bin/uninstall.sh

CMD [ "/bin/rsyslog.sh" ]
