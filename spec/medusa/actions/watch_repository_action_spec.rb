# frozen_string_literal: true

RSpec.describe WatchRepositoryAction do
  before do
    settings.key_value_store.clear
  end
  let(:watch) { described_class.new(settings) }
  let(:repository_id) { 'github.com/rubocop-hq/rubocop' }

  it 'adds a repository to the watchlist in the store' do
    watch.call(repository_id)
    expect(settings.key_value_store.fetch('watched_repositories')).to include(repository_id)
  end

  it 'does not add the same repository twice' do
    watch.call(repository_id)
    watch.call(repository_id)
    recorded = settings.key_value_store.fetch('watched_repositories').count do |r|
      r == repository_id
    end

    expect(recorded).to be(1)
  end
end
