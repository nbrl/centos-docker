FROM centos:centos6
RUN yum -y update
RUN yum -y install openssh-server
RUN service sshd start
RUN chkconfig sshd on

# Add vagrant user and key (with uid 1000 to match Ubuntu for syncing)
RUN yum -y install sudo
RUN useradd --create-home -s /bin/bash vagrant -G wheel -u 1000

# Allow sudo over SSH without tty (for vagrant)
RUN sed -i 's/^Defaults[ \t]\+requiretty//' /etc/sudoers

# Install things you would expect to be installed already
RUN yum -y install git tar rsync
RUN yum -y groupinstall "Development Tools"

# Configure SSH access.
RUN sudo -H -u vagrant bash -c 'mkdir -p /home/vagrant/.ssh'
RUN sudo -H -u vagrant bash -c 'curl https://raw.githubusercontent.com/mitchellh/vagrant/master/keys/vagrant.pub > /home/vagrant/.ssh/authorized_keys'
RUN echo -n 'vagrant:vagrant' | chpasswd

# Enable passwordless sudo for users in the "sudo" group, i.e. vagrant.
RUN echo 'vagrant ALL = NOPASSWD: ALL' > /etc/sudoers.d/vagrant
RUN chmod 440 /etc/sudoers.d/vagrant

# Keep box running
CMD ["/usr/sbin/sshd", "-D"]
