# frozen_string_literal: true

RSpec.describe DashboardQuery do
  before(:context) do
    repository_id = 'github.com/rubocop-hq/rubocop'
    WatchRepositoryAction.new(settings).call(repository_id, 'Fix')
    WatchRepositoryAction.new(settings).call('github.com/rails/rails', 'Fix')
    MatchRepositoryAction.new(settings).call(repository_id)
    @most_recent_commit_id = settings.git_client.commits(
      repository_id, limit: 1
    ).first.id
    @result = DashboardQuery.new(settings).call
  end
  attr_reader :most_recent_commit_id, :result

  it 'returns subscriptions' do
    expect(result).to contain_exactly(
      be_a(DashboardQuery::Subscription),
      have_attributes(
        repository: 'github.com/rubocop-hq/rubocop',
        pattern: 'Fix'
      )
    )
  end

  it 'includes the last scanned commit' do
    expect(result).to contain_exactly(
      be_a(DashboardQuery::Subscription),
      have_attributes(last_scanned: most_recent_commit_id)
    )
  end

  it 'includes all matches' do
    expect(result).to contain_exactly(
      be_a(DashboardQuery::Subscription),
      have_attributes(matches: satisfy { |commits| !commits.empty? })
    )
  end

  context 'when a repository has never been scanned' do
    it 'returns "unknown" for last_scanned' do
      last_scanned_returns_unknown = satisfy do |object|
        object.last_scanned == 'unknown'
      end
      expect(result).to contain_exactly(
        be_a(DashboardQuery::Subscription),
        last_scanned_returns_unknown
      )
    end
  end
end
