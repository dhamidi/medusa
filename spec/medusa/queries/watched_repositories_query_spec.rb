# frozen_string_literal: true

RSpec.describe WatchedRepositoriesQuery do
  let(:watched_repositories) { described_class.new(settings) }

  before do
    settings.key_value_store.clear
  end

  it 'returns all repositories that have been watched' do
    WatchRepositoryAction.new(settings).call('rubocop-hq/rubocop')
    WatchRepositoryAction.new(settings).call('rails/rails')
    expect(watched_repositories.call).to eql(['rubocop-hq/rubocop', 'rails/rails'])
  end

  context 'when no repositories have been watched yet' do
    it 'returns an empty array' do
      expect(watched_repositories.call).to eql([])
    end
  end
end
