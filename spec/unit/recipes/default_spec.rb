require 'spec_helper'

describe "wonderstuff::default" do
  let(:chef_run) do
    runner = ChefSpec::Runner.new(
      log_level: :error
    )
    Chef::Config.force_logger true
    runner.converge('recipe[wonderstuff::default]')
  end

  it "installs the lighttpd package" do
    expect(chef_run).to install_package('lighttpd')
  end

  it "creates a webpage to be served" do
    expect(chef_run).to render_file('/var/www/index.html').with_content('Wonderstuff Design is a boutique graphics design agency.')
  end

  it "starts the lighttpd service" do
    expect(chef_run).to start_service('lighttpd')
  end

  it "enables the lighttpd service" do
    expect(chef_run).to enable_service('lighttpd')
  end
end