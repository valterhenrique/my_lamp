name 'my_lamp'
maintainer 'Valter Henrique'
maintainer_email 'valterhenrique85@gmail.com'
license 'all_rights'
description 'Installs/Configures a LAMP (Linux, Apache, MySQL, PHP) server'
long_description 'Installs/Configures a LAMP (Linux, Apache, MySQL, PHP) server'
version '0.1.0'

issues_url 'https://github.com/valterhenrique/my_lamp/issues' if respond_to?(:issues_url)
source_url 'https://github.com/valterhenrique/my_lamp' if respond_to?(:source_url)

depends 'apt', '~> 6.0'
depends 'firewall', '~> 2.5'
depends 'httpd', '~> 0.4'
depends 'mysql', '~> 8.2'
depends 'mysql2_chef_gem', '~> 1.1'
depends 'database', '~> 6.1' #chef supermarket
