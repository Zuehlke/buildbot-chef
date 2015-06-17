require 'spec_helper'

describe 'buildbot-chef::default' do
  #
  # Serverspec examples can be found at
  # http://serverspec.org/resource_types.html
  #

  it 'starts the buildbot master service' do
    expect(service('buildbot')).to be_running
  end
  it 'enables the buildbot service on startup' do
    expect(service('buildbot')).to be_enabled
  end
  it 'runs buildbot on port 8010' do
    expect(port(8010)).to be_listening
  end
  it 'starts the buildbot slave' do
    expect(service('buildslave')).to be_running
  end
  it 'enables the buildbot slave service on startup' do
    expect(service('buildslave')).to be_enabled
  end

  it 'installs buildbot version 0.8.12' do
    cmd = command('wget -qO- localhost:8010')
    expect(cmd.stdout).to include '(0.8.12)'
  end

end
