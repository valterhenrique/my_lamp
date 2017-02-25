def random_password
  require 'securerandom'
  SecureRandom.base64
end

default['firewall']['allow_ssh']=true
default['my_lamp']['open_ports'] = [22, 80, 443]

default['my_lamp']['group'] = 'web_admin'
default['my_lamp']['user'] = 'web_admin'

default['my_lamp']['document_root'] = '/var/www/my_lamp/public_html'

normal_unless['my_lamp']['database']['root_pw'] = random_password
normal_unless['my_lamp']['database']['admin_pw'] = random_password
