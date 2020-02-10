# frozen_string_literal: true

RSpec.describe UnwatchRepositoryAction do
  let(:unwatch) { described_class.new(settings) }

  it 'does nothing when no subscription exists for the repository' do
    expect { unwatch.call('rubocop-hq/rubocop') }.not_to raise_error
  end

  context 'when the repository is watched' do
    it 'removes the repository from the list of watched repositories' do
      WatchRepositoryAction.new(settings).call('github.com/rubocop-hq/rubocop', 'Fix')
      expect do
        unwatch.call('github.com/rubocop-hq/rubocop')
      end.to(change { WatchedRepositoriesQuery.new(settings).call.size })
    end
  end
end
