name             'buildbot-chef'
maintainer       'kimo'
maintainer_email 'kimo@zuehlke.com'
license          'All rights reserved'
description      'A minimal buildbot cookbook'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.0.1'

depends 'apt', '2.7.0'
depends 'python', '1.4.4'
depends 'chef-dk', '3.1.0'
depends 'vagrant', '0.2.2'
depends 'virtualbox', '1.0.3'
