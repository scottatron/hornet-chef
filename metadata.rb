name             'hornet'
maintainer       'Scott Arthur'
maintainer_email 'scott@scottatron.com'
license          'All rights reserved'
description      'Installs/Configures hornet'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

depends 'apt', '>= 2.4'

# default, ruby, mysql, redis
depends 'rbenv'
depends 'mysql'
depends 'redisio'

# captain
depends 'sudo'
depends 'ssh' # https://github.com/scottatron/chef-ssh

# nginx
depends 'nginx'

# ci-runner
depends 'gitlab-ci'
depends 'phantomjs'

# depends 'git'  , '~> 2.7'
