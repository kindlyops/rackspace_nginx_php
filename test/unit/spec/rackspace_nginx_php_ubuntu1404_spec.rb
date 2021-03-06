require_relative 'spec_helper'
require_relative 'ubuntu1404_options'

describe 'rackspace_nginx_php_test::default on Ubuntu 14.04' do
  before do
    stub_resources
  end

  context 'Nginx' do
    cached(:chef_run) do
      ChefSpec::SoloRunner.new(UBUNTU1404_SERVICE_OPTS) do |node|
      end.converge('rackspace_nginx_php_test::default')
    end
    it_behaves_like 'Nginx', 'default', 'override'
    it_behaves_like 'PHP-FPM', 'ubuntu', 'default'
    it_behaves_like 'APT php repo', 5.6
  end

  context 'disable PHP packages install' do
    cached(:chef_run) do
      ChefSpec::SoloRunner.new(UBUNTU1404_SERVICE_OPTS) do |node|
        node.set['rackspace_nginx_php']['php_packages_install']['enable'] = false
      end.converge('rackspace_nginx_php_test::default')
    end
    it_behaves_like 'Nginx', 'default', 'override'
    it_behaves_like 'PHP-FPM', 'ubuntu', 'default'
    it_behaves_like 'APT php repo', 5.6
    it_behaves_like 'PHP-fpm packages without PHP packages, version 5.6 UBUNTU'
  end

  context 'PHP 5.5' do
    cached(:chef_run) do
      ChefSpec::SoloRunner.new(UBUNTU1404_SERVICE_OPTS) do |node|
        node.set['rackspace_nginx_php']['php_version'] = '5.5'
      end.converge('rackspace_nginx_php_test::default')
    end
    it_behaves_like 'Nginx', 'default', 'override'
    it_behaves_like 'PHP-FPM', 'ubuntu', 'default'
    it_behaves_like 'APT php repo', 5.5
    it_behaves_like 'PHP and PHP-fpm packages version 5.5 UBUNTU'
  end

  context 'PHP 5.6' do
    cached(:chef_run) do
      ChefSpec::SoloRunner.new(UBUNTU1404_SERVICE_OPTS) do |node|
        node.set['rackspace_nginx_php']['php_version'] = '5.6'
      end.converge('rackspace_nginx_php_test::default')
    end
    it_behaves_like 'Nginx', 'default', 'override'
    it_behaves_like 'PHP-FPM', 'ubuntu', 'default'
    it_behaves_like 'APT php repo', 5.6
    it_behaves_like 'PHP and PHP-fpm packages version 5.6 UBUNTU'
  end
end
