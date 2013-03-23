puppet-hg-ssh
=============

Puppet module for managing SSH access to Mercurial libraries using the hg-ssh script

Example:
--------

    hgssh::user { 'user1':
      name         => 'Some User',
      repositories => 'group/repo1 group/repo2',
      key          => 'thePublicKeyItself',
      email        => 'someuser@example.com',
    }
  
will result in the following being added to `~hg/.ssh/authorized_keys`:

    command="hg-ssh sgroup/repo1 group/repo2" ssh-rsa thePublicKeyItself Some User <someuser@example.com>

