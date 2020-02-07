# frozen_string_literal: true

RSpec.describe WatchRepositoryAction do
  before do
    settings.key_value_store.clear
  end
  let(:watch) { described_class.new(settings) }
  let(:repository_id) { 'github.com/rubocop-hq/rubocop' }

  it 'adds a repository to the watchlist in the store' do
    watch.call(repository_id, 'Fix')
    expect(settings.key_value_store.fetch('watched_repositories')).to contain_exactly(
      Subscription.new(
        repository: repository_id,
        pattern: 'Fix'
      )
    )
  end

  it 'does not add the same repository twice' do
    watch.call(repository_id, 'Fix')
    watch.call(repository_id, 'Fix')
    recorded = settings.key_value_store.fetch('watched_repositories').count do |r|
      r.repository == repository_id
    end

    expect(recorded).to be(1)
  end

  context 'when the pattern changes' do
    it 'updates the pattern without creating a new subscription' do
      watch.call(repository_id, 'Fix')
      watch.call(repository_id, 'Bug')
      subscription = Subscription.new(
        repository: repository_id,
        pattern: 'Bug'
      )
      expect(settings.key_value_store.fetch('watched_repositories')).to eq([subscription])
    end
  end
end
