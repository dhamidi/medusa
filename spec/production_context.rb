# frozen_string_literal: true

RSpec.shared_context 'production_settings' do
  before(:context) do
    @settings = Settings.default
  end
  attr_reader :settings
end
