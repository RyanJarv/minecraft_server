default['sds-dns-caching']['dnsmasq']['listen-address'] = '127.0.0.1'

default['resolvconf']['tail'] = [
    'options timeout:1 attempts:5'
]

default['sds-dns-caching']['dnsmasq']['servers'] = nil