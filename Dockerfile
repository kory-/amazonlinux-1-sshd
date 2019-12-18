FROM amazonlinux:1

ARG USER

# install packages
RUN echo "%_netsharedpath /sys:/proc" >> /etc/rpm/macros.dist
RUN yum clean all \
    && yum update -y \
	&& yum -y install vim \
	sudo passwd openssh openssh-server openssh-clients \
	iproute procps initscripts wget curl

# create users
RUN useradd $USER
RUN passwd -f -u $USER

# setup sudoers
RUN echo "$USER ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# setup SSH
RUN /usr/sbin/sshd-keygen
RUN mkdir -p /home/$USER/.ssh; chown $USER /home/$USER/.ssh; chmod 700 /home/$USER/.ssh
ADD ./id_rsa.pub /home/$USER/.ssh/authorized_keys
RUN chown $USER /home/$USER/.ssh/authorized_keys
RUN chmod 600 /home/$USER/.ssh/authorized_keys

RUN echo LANG="ja_JP.UTF-8" > /etc/sysconfig/i18n
RUN echo ZONE="Asia/Tokyo"\
UTC=true > /etc/sysconfig/clock
RUN echo NETWORKING=yes\
HOSTNAME=localhost.localdomain\
NOZEROCONF=yes > //etc/sysconfig/network

EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]