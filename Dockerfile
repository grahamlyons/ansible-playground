FROM centos:7

RUN yum install -y openssh-server python sudo
RUN mkdir /var/run/sshd && chmod 0755 /var/run/sshd

COPY sudoers /etc/sudoers

RUN adduser anonymous && \
    sed -i -re 's/^anonymous:[^:]+:/anonymous::/' /etc/passwd /etc/shadow && \
    groupadd sudo && \
    usermod -aG sudo anonymous && \
    echo -e "\nMatch user anonymous\n    PermitEmptyPasswords yes" >> /etc/ssh/sshd_config && \
    sed -i'' -e 's/@include common-auth/auth [success=1 default=ignore] pam_unix.so nullok\nauth requisite pam_deny.so\nauth required pam_permit.so/' /etc/pam.d/sshd

RUN /usr/bin/ssh-keygen -A

CMD ["/usr/sbin/sshd", "-D"]
