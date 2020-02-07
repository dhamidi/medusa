# frozen_string_literal: true

class ScanRepositoryAction < BaseAction
  def call(repository_id)
    after = query(LastScannedCommitQuery, repository_id)
    commits = @context.git_client.commits(repository_id, limit: 10, after: after)
    store_most_recent_commit_id(repository_id, commits.first.id) if commits&.size&.positive?
    commits
  end

  private

  def store_most_recent_commit_id(repository_id, commit_id)
    @context.key_value_store.store("scan/#{repository_id}/last_scanned", commit_id)
  end
end
