

require 'spec_helper'

describe 'mongodb-server::default' do
  context 'When all attributes are default, on an Ubuntu 16.04' do
    let(:chef_run) do
      # for a complete list of available platforms and versions see:
      # https://github.com/customink/fauxhai/blob/master/PLATFORMS.md
      runner = ChefSpec::ServerRunner.new(platform: 'ubuntu', version: '16.04')
      runner.converge(described_recipe)
    end

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end

    it 'installs mongodb-org' do
      expect(chef_run).to upgrade_package 'mongodb-org'
    end

    it 'starts the mongod' do
      expect(chef_run).to start_service 'mongod'
    end

    it 'enables the mongod' do
      expect(chef_run).to enable_service 'mongod'
    end

    it 'add repo for mongo' do
      expect(chef_run).to add_apt_repository 'mongodb-org'
    end

    it 'expect to make template service' do
      expect(chef_run).to create_template '/etc/systemd/system/mongod.service'
      template = chef_run.template('/etc/systemd/system/mongod.service')
    end

    it 'expect to make template conf' do
      expect(chef_run).to create_template '/etc/mongod.conf'
      template = chef_run.template('/etc/mongod.conf')
    end

    it 'apt update' do
      expect(chef_run).to update_apt_update 'update'
    end

  end
end
