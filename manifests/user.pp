# User type
# Parameters:
#   name:         User's name
#   email:        User's email
#   repositories: paths to allowed repositories
#   key:          SSH key
#   type:         ssh-rsa or ssh-dsa
define hgssh::user (
  $name,
  $repositories,
  $key,
  $email = UNDEF,
  $type = 'ssh-rsa',
) {

  if $email == undef {
    $keycomment = $name
  } else {
    $keycomment = "${name} <${email}>"
  }

  ssh_authorized_key { "HG-SSH-${name}":
    ensure  => present,
    user    => 'hg',
    key     => $key,
    name    => $keycomment,
    options => "command=\"hg-ssh ${repositories}\"",
    type    => $type,
  }
}

