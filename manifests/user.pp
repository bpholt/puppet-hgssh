# ## Define: user
#
# Defines a user that can access a specific set of hg repositories.
#
# ### Parameters
#
# [*name*]
#   User's name. Will be added to the key comment.
#
# [*repositories*]
#   Path(s) to repositories accessible to the user. Will be added
#   to the `command` part of the key entry. Uses the same rules
#   as hg-ssh.
#
# [*key*]
#   The public key itself; generally a long string of hex characters. The
#   key attribute may not contain whitespace: Omit key headers (e.g. 'ssh-rsa')
#   and key identifiers (e.g. 'joe@joescomputer.local') found in the public
#   key file.
#
# [*email*]
#   (Optional) User's email. If set, will be added to the key comment.
#
# [*type*]
#   (Optional) `ssh-rsa` or `ssh-dsa`
#
# ### Examples
#
#     hgssh::user { 'user1':
#       name         => 'Some User',
#       repositories => 'group/repo1 group/repo2',
#       key          => 'keybytes',
#       email        => 'someuser@example.com',
#     }
#
# ### Authors
#
# Brian P. Holt <bholt@planetholt.com>
#
# ### Copyright
#
# Copyright 2013 Brian P. Holt
#
define hgssh::user (
  $name,
  $repositories,
  $key,
  $email = undef,
  $type = 'ssh-rsa',
) {

  if $email == undef {
    $keycomment = $name
  } else {
    $keycomment = "${name} <${email}>"
  }

  ssh_authorized_key { "hg-ssh-${name}":
    ensure  => present,
    user    => 'hg',
    key     => $key,
    name    => $keycomment,
    options => "command=\"hg-ssh ${repositories}\"",
    type    => $type,
  }
}

