# veewee-vnz

**Build vagrant boxes for tests and profits**

## Requirements

 * virtualbox 4.2.x
 * vagrant 1.2.x
 * libvirt

## [jedi4ever/veewee](https://github.com/jedi4ever/veewee)

Veewee definitions based on 'ubuntu-12.04.1-server-amd64-packages' templates
 * ruby: 1.9.3, ubuntu package 'ruby1.9.1-full'
 * chef: 11.x, script from [opscode](https://www.opscode.com/chef/install.sh)
 * apt sources: France, mirror ftp.free.fr
 * kernel: 3.2.0-x

## One time setup after cloning

    $ gem install bundler --no-ri --no-rdoc
    $ cd veewee-vnz
    $ bundle install

## Build a box

    $ bundle exec veewee vbox list
    $ bundle exec veewee vbox build -n precise

## Packaging for berkshelf and test-kitchen

    $ bundle exec veewee vbox export precise

## Packaging for chef-server

    $ vagrant package --base precise --output dev.box --vagrantfile Vagrantfile.pkg --include validation.pem

## Add to vagrant

    $ vagrant box add precise precise.box


