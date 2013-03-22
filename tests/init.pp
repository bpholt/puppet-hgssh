# The baseline for module testing used by Puppet Labs is that each manifest
# should have a corresponding test manifest that declares that class or defined
# type.
#
# Tests are then run by using puppet apply --noop (to check for compilation
# errors and view a log of events) or by fully applying the test in a virtual
# environment (to compare the resulting system state to the desired state).
#
include hgssh

hgssh::user { 'user1':
  name         => 'Some User',
  repositories => 'group/repo1 group/repo2',
  key          => 'keybytes',
  email        => 'someuser@example.com',
}

