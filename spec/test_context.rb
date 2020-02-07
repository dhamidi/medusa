# frozen_string_literal: true

RSpec.shared_context 'test_settings' do
  test_commits = begin
    commit_attributes = YAML.load_file(File.join(File.dirname(__FILE__), 'fixtures', 'rubocop_commits.yml'))
    commit_attributes.map do |attributes|
      Commit.new(attributes)
    end
  end
  git_client = TestGitClient.new('github.com/rubocop-hq/rubocop' => test_commits)
  before(:context) do
    @settings = Settings.new(
      git_client: git_client,
      key_value_store: PstoreKeyValueStore.new('test.pstore')
    )
  end
  attr_reader :settings
end
