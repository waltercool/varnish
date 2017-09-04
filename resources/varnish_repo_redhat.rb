provides :varnish_repo, platform_family: ['rhel', 'fedora']

default_action :configure

property :major_version, kind_of: Float, equal_to: [2.1, 3.0, 4.0, 4.1], default: lazy { node['varnish']['major_version'] }

action :configure do
  # packagecloud repos omit dot from major version
  major_version_no_dot = new_resource.major_version.to_s.tr('.', '')
  yum_repository "varnish-cache_#{new_resource.major_version}" do
    description "Varnish #{new_resource.major_version} repo (#{node['platform_version']} - $basearch)"
    url "https://packagecloud.io/varnishcache/varnish#{major_version_no_dot}/el/#{node['platform_version'].to_i}/$basearch"
    gpgcheck false
    action :create
  end
end
