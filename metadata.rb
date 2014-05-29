name             'hornet'
maintainer       'Scott Arthur'
maintainer_email 'scott@scottatron.com'
license          'All rights reserved'
description      'Installs/Configures hornet'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

# default, ruby, mysql
depends 'rbenv', '~> 1.7'
depends 'mysql', '~> 3.0'

# captain
depends 'sudo' , '~> 2.3'
depends 'ssh'  , '~> 0.6' # https://github.com/scottatron/chef-ssh

# depends 'apt'  , '~> 2.3'
# depends 'git'  , '~> 2.7'
# depends 'nginx', '~> 2.2'

# depends 'phantomjs', '~> 1.0'
