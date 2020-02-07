# frozen_string_literal: true

class Settings < BaseModel
  attribute :git_client
  attribute :key_value_store

  # Number of commits to scan when watching a repository for the first
  # time.
  attribute :recent_commits, :integer, default: 10

  def self.default
    new(
      git_client: OctokitGitClient.new,
      key_value_store: PstoreKeyValueStore.new('production.pstore')
    )
  end
end
