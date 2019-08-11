# Pam Duo for Ubuntu

Integrate pam_duo in Ubuntu Machine using Docker in a few minutes.

## Installing

I recommend using something like Vagrant for testing. If Duo Unix is configured incorrectly it has the potential to lock you out of a system. It's better to have that happen on a virtual machine instead of your computer.

1. Visit the Duo Admin Panel and create a "Unix" integration if you don't have one already.

2. Copy your ikey, skey, and api_host into the `duo.env` file

    ```shell
        mv duo.env.example duo.env
    ```

3. SSH into the ubuntu machine, make sure to create a right user and configure the keys so you can SSH.

4. Install Docker in ubuntu if not installed.

    ```shell

        # Installing Docker
        sudo apt-get update
        sudo apt-get -y install \
            apt-transport-https \
            ca-certificates \
            curl \
            gnupg-agent \
            software-properties-common

        curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
        sudo apt-key fingerprint 0EBFCD88
        sudo add-apt-repository \
        "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
        $(lsb_release -cs) \
        stable"

        sudo apt-get update
        sudo apt-get -y install docker-ce docker-ce-cli containerd.io
    ```

5. Run this command--

    ```shell
        sudo docker run \
            --rm \
            --volume /etc/ssh:/etc/ssh \
            --volume /etc/duo:/duo \
            --volume /lib64/security:/out \
            --volume /etc/pam.d:/etc/pam.d \
            --env-file duo.env \
            ankitjain28/pam_duo:ubuntu
    ```

6. Restart the SSH service

    ```shell
        sudo service ssh restart
    ```

7. Now try to SSH in the same machine or before that you can try this.

    ```shell
        ssh localhost
    ```

    To make sure everything is working as expected.

## Demo

I have set up a Demo using Vagrant (ubuntu box) to implement the pam_duo.

**Note**: I have made the user `ankit` in Duo dashboard so make changes in Vagrantfile accordingly.

### Steps for Demo

1. Install dependencies

    [VirtualBox](https://www.virtualbox.org/) 4.3.10 or greater.
    [Vagrant](https://www.vagrantup.com/downloads.html) 1.6.3 or greater.

2. Clone this project and get it running!

    ```shell
        git clone https://github.com/ankitjain28may/pam_duo_linux
        cd pam_duo_linux/ubuntu
    ```

3. Open Vagrantfile and change `./install.sh ankit` to whatever username you want -> `./install.sh username`.

4. Run this commands-

    ```shell
        # To craete a ubuntu VM
        $ vagrant up

        # First time
        $ vagrant ssh

        # create keys and try local ssh so as you can enroll your device
        $ sudo su - username
        $ ssh-keygen -t rsa
        $ cat ~/.ssh/id_rsa.pub >> authorized_keys
        $ ssh localhost

        # SSH in VM
        $ ssh username@localhost -p 2222
    ```

    **Note:** In case you are facing issues while SSH, open Vagrantfile and add this-

    ```shell
        config.ssh.username = 'username'

        # Now SSH again
        $ vagrant ssh
    ```

Read more about pam_duo from its docs: [Duo Unix - Two-Factor Authentication for SSH with PAM Support (pam_duo)](https://duo.com/docs/duounix)
