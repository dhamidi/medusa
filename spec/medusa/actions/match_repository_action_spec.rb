# frozen_string_literal: true

RSpec.describe MatchRepositoryAction do
  let(:match_repository) { described_class.new(settings) }

  before(:context) do
    @repository = 'github.com/rubocop-hq/rubocop'
    @recent_commits = settings.git_client.commits(repository)
    @pattern = recent_commits.last.message.split(' ').first
    WatchRepositoryAction.new(settings).call(repository, pattern)
  end
  attr_reader :recent_commits, :pattern, :repository

  context 'when a commit message includes the watched pattern' do
    it 'records a match for each commit in a scan' do
      expected_commits = recent_commits.select do |c|
        c.message.include?(pattern)
      end

      match_repository.call(repository)

      actual_commits = settings.key_value_store.fetch(
        "match/#{repository}", []
      )

      expect(actual_commits).to eq(expected_commits)
    end
  end
end
