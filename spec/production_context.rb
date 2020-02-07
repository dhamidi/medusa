# frozen_string_literal: true

RSpec.shared_context 'production_settings' do
  before(:context) do
    @settings = Settings.new(
      git_client: OctokitGitClient.new,
      key_value_store: PstoreKeyValueStore.new('production.pstore')
    )
  end
  attr_reader :settings
end
