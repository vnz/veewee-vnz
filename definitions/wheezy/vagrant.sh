# Set up Vagrant.

date > /etc/vagrant_box_build_time

# Create the user vagrant with password vagrant
useradd -G sudo -p $(perl -e'print crypt("vagrant", "vagrant")') -m -s /bin/bash -N vagrant

# Install vagrant keys
mkdir -pm 700 /home/vagrant/.ssh
curl -Lo /home/vagrant/.ssh/authorized_keys \
  'https://raw.github.com/mitchellh/vagrant/master/keys/vagrant.pub'
chmod 0600 /home/vagrant/.ssh/authorized_keys
curl -Lo /home/vagrant/.bashrc \
  'https://raw.github.com/vnz/veewee-vnz/master/dotfiles/bashrc'
chmod 0644 /home/vagrant/.bashrc
chown -R vagrant:vagrant /home/vagrant
curl -Lo /root/.bashrc \
  'https://raw.github.com/vnz/veewee-vnz/master/dotfiles/bashrc'


# Customize the message of the day
echo 'Welcome to your Ebz.io virtual machine.' > /etc/motd

# Install NFS client
apt-get -y install nfs-common


