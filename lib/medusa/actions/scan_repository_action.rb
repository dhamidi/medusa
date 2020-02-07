# frozen_string_literal: true

class ScanRepositoryAction
  def initialize(context)
    @context = context
  end

  def call(repository_id)
    after = last_scanned_commit_id(repository_id)
    commits = @context.git_client.commits(repository_id, limit: 10, after: after)
    if commits&.size&.positive?
      store_most_recent_commit_id(repository_id, commits.first.id)
    end
    commits
  end

  def last_scanned_commit_id(repository_id)
    @context.key_value_store.fetch("scan/#{repository_id}/last_scanned", nil)
  end

  def store_most_recent_commit_id(repository_id, commit_id)
    @context.key_value_store.store("scan/#{repository_id}/last_scanned", commit_id)
  end
end
