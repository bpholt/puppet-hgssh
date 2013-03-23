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
# [*base_directory*]
#   (Optional) Base directory to which the repository paths above are relative.
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
  $base_directory = undef,
  $type = 'ssh-rsa',
) {

  if $email == undef {
    $keycomment = $name
  } else {
    $keycomment = "${name} <${email}>"
  }

  $primary_command = "hg-ssh ${repositories}"
  if $base_directory == undef {
    $command = "command=\"${primary_command}\""
  } else {
    $command = "command=\"cd ${base_directory} && ${primary_command}\""
  }

  ssh_authorized_key { "hg-ssh-${name}":
    ensure  => present,
    user    => 'hg',
    key     => $key,
    name    => $keycomment,
    options => $command,
    type    => $type,
  }
}

