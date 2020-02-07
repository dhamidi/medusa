# frozen_string_literal: true

RSpec.describe ScanRepositoryAction do
  before :context do
    @scan = described_class.new(settings)
    @commits = scan.call('github.com/rubocop-hq/rubocop')
    @actual_commits = settings.git_client.commits('github.com/rubocop-hq/rubocop', limit: 10)
  end
  attr_reader :commits, :actual_commits, :scan

  it 'scans ten commits by default' do
    expect(commits).to match_array(Array.new(10) { be_a(Commit) })
  end

  context 'when the repository does not exist' do
    it 'returns nil' do
      expect(scan.call('does-not-exist')).to be_nil
    end
  end
end
