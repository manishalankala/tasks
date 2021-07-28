FROM ansible
RUN apt install python3 -y
RUN pip3 install "ansible-lint[yamllint]"
RUN ansible-galaxy collection install ansible.posix
RUN ansible-galaxy collection install community.docker
