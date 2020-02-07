# frozen_string_literal: true

RSpec.describe WatchedRepositoriesQuery do
  let(:watched_repositories) { described_class.new(settings) }

  before do
    settings.key_value_store.clear
  end

  it 'returns all repositories that have been watched' do
    WatchRepositoryAction.new(settings).call('rubocop-hq/rubocop', 'Fix')
    WatchRepositoryAction.new(settings).call('rails/rails', 'Merge pull request')
    expect(watched_repositories.call).to eq(
      [
        Subscription.new(repository: 'rubocop-hq/rubocop', pattern: 'Fix'),
        Subscription.new(repository: 'rails/rails', pattern: 'Merge pull request')
      ]
    )
  end

  context 'when no repositories have been watched yet' do
    it 'returns an empty array' do
      expect(watched_repositories.call).to eql([])
    end
  end
end
