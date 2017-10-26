
# # encoding: utf-8

# Inspec test for recipe mongodb-server::default

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

unless os.windows?
  # This is an example test, replace with your own test.
  describe user('root') do
    it { should exist }
  end
end

describe package('mongodb-org') do
	it { should be_installed }
  its('version') { should match /3\./ }
end

describe service('mongod') do
  
  it { should be_running }
  it { should be_enabled }
end

describe port(27017) do
  it { should be_listening }
end