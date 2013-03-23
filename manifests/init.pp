# == Class: hgssh
#
# Defines a type to manage SSH keys for users accessing Mercurial
# repositories via SSH. Including the base class will ensure
# Mercurial is installed and an `hg` user exists.
#
# === Authors
#
# Brian P. Holt <bholt@planetholt.com>
#
# === Copyright
#
# Copyright 2013 Brian P. Holt, unless otherwise noted.
#
class hgssh {
  package { 'mercurial':
    ensure => present,
  }
  user { 'hg':
    ensure => present,
  }

}
