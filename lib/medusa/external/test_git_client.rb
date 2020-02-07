# frozen_string_literal: true

class TestGitClient
  def initialize(repository_to_history_hash)
    @commits_by_repository = repository_to_history_hash
  end

  def commits(repository_id, limit: 10, after: nil)
    commits = commits_by_repository[repository_id]
    return unless commits

    commits.take_while do |commit|
      next true unless after

      commit.id != after
    end.take(limit)
  end

  attr_reader :commits_by_repository
end
