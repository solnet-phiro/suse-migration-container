########################################################################################################################

FROM opensuse:42.2

########################################################################################################################
# Install base system and ancillary libraries.
RUN zypper --non-interactive refresh
RUN zypper -n install python
RUN zypper -n install python-pip
RUN zypper -n install python3
RUN zypper -n install python3-pip
########################################################################################################################
# Setup and configure sshd
RUN zypper --non-interactive install openssh
RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN echo "AllowUsers vagrant svc_*" >> /etc/ssh/sshd_config
RUN echo "PasswordAuthentication yes" >> /etc/ssh/sshd_config
# Install the ssh host keys
RUN /bin/rm -f /etc/ssh/ssh_host_*
RUN /usr/bin/ssh-keygen -f /etc/ssh/ssh_host_key -b 2048 -N '' -t rsa1
RUN /usr/bin/ssh-keygen -f /etc/ssh/ssh_host_rsa_key -b 2048 -N '' -t rsa
RUN /usr/bin/ssh-keygen -f /etc/ssh/ssh_host_dsa_key -b 1024 -N '' -t dsa

########################################################################################################################
# Install sudo as we need it for the ansible jobs later, also install the ansible python ancillaries.
RUN zypper -n install sudo
# Install supervisor to run the sshd daemon without systemd.
RUN zypper -n install --type pattern devel_basis
RUN zypper -n install --type pattern devel_python
RUN zypper -n install --type pattern devel_python3
RUN zypper -n install python-devel python3-devel libffi-devel openssl-devel
RUN pip2 install supervisor pycrypt paramiko
RUN pip3 install pycrypt paramiko
RUN mkdir -p /var/log/supervisor
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

########################################################################################################################
# Create vagrant user as I created the ansible scripts for vagrant a long time ago and I am lazy as.
RUN useradd -m vagrant
RUN usermod -a -G wheel vagrant
RUN echo "vagrant ALL=(ALL) ALL" >> /etc/sudoers
RUN echo 'vagrant:vagrant' | chpasswd
RUN echo 'root:vagrant' | chpasswd
COPY sudoers /etc/sudoers


########################################################################################################################
# Supervisor will the the init daemon to keep the container running.
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]