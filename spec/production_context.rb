# frozen_string_literal: true

RSpec.shared_context 'production_settings' do
  before(:context) do
    @settings = Settings.new(
      git_client: OctokitGitClient.new
    )
  end
  attr_reader :settings
end
