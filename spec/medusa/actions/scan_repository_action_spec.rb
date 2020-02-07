# frozen_string_literal: true

RSpec.describe ScanRepositoryAction do
  let(:scan) { described_class.new(settings) }
  let(:actual_commits) { settings.git_client.commits('github.com/rubocop-hq/rubocop') }

  before do
    settings.key_value_store.clear
  end

  it 'scans ten commits by default' do
    commits = scan.call('github.com/rubocop-hq/rubocop')
    expect(commits).to match_array(Array.new(10) { be_a(Commit) })
  end

  context 'when a repository is scanned multiple times' do
    it 'only returns commits after the last scan' do
      initial_scan = scan.call('github.com/rubocop-hq/rubocop')
      expected_commits = settings.git_client.commits('github.com/rubocop-hq/rubocop',
                                                     after: initial_scan.first.id)

      next_scan = scan.call('github.com/rubocop-hq/rubocop')
      expect(next_scan).to eq(expected_commits)
    end
  end

  context 'when the repository does not exist' do
    it 'returns nil' do
      expect(scan.call('does-not-exist')).to be_nil
    end
  end
end
