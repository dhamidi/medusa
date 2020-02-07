# frozen_string_literal: true

class Settings < BaseModel
  attribute :git_client
  attribute :key_value_store

  # Number of commits to scan when watching a repository for the first
  # time.
  attribute :recent_commits, :integer, default: 10
end
