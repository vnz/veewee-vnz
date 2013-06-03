# postinstall.sh created from Mitchell's official lucid32/64 baseboxes

date > /etc/vagrant_box_build_time

echo 'Configure vagrant public key'
mkdir /home/vagrant/.ssh
chmod 700 /home/vagrant/.ssh
wget -q --no-check-certificate \
  'https://raw.github.com/mitchellh/vagrant/master/keys/vagrant.pub' \
   -O /home/vagrant/.ssh/authorized_keys
chmod 600 /home/vagrant/.ssh/authorized_keys
chown -R vagrant /home/vagrant/.ssh

echo 'Configure sudo'
echo 'vagrant ALL=NOPASSWD:ALL' > /etc/sudoers.d/vagrant
chmod 440 /etc/sudoers.d/vagrant

echo 'Configure SSH'
echo 'UseDNS no' >> /etc/ssh/sshd_config

echo 'Configure DHCP'
echo 'pre-up sleep 2' >> /etc/network/interfaces

echo 'Build virtualbox guest additions'
aptitude -q=2 -y update
aptitude -q=2 -y install linux-headers-$(uname -r) build-essential dkms
VBOX_VERSION=$(cat /home/vagrant/.vbox_version)
mount -o loop,ro /home/vagrant/VBoxGuestAdditions_$VBOX_VERSION.iso /mnt
sh /mnt/VBoxLinuxAdditions.run
umount /mnt
rm /home/vagrant/VBoxGuestAdditions_$VBOX_VERSION.iso

echo 'Update system'
aptitude -q=2 -y safe-upgrade

echo 'Install chef'
apt-get -q=2 -y install zlib1g-dev libssl-dev libreadline-gplv2-dev ruby1.9.1-full curl
curl -L https://www.opscode.com/chef/install.sh | bash
gem install ruby-shadow --no-ri --no-rdoc -q
gem clean

echo 'Cleanup packages'
#aptitude -q=2 -y remove build-essential
aptitude -q=2 -y autoclean
aptitude -q=2 -y clean

update-grub

echo 'Zero out the free space to save space in the final image'
dd if=/dev/zero of=/EMPTY bs=1M
rm -f /EMPTY

echo 'Cleanup DHCP leases'
rm /var/lib/dhcp/*

echo 'Cleanup udev rules'
rm /etc/udev/rules.d/70-persistent-net.rules
mkdir /etc/udev/rules.d/70-persistent-net.rules
rm -rf /dev/.udev/
rm /lib/udev/rules.d/75-persistent-net-generator.rules

exit
