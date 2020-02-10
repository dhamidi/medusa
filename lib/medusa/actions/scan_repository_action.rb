# frozen_string_literal: true

class ScanRepositoryAction < BaseAction
  def call(repository_id)
    after = query(LastScannedCommitQuery, repository_id)
    commits = context.git_client.commits(repository_id, limit: 10, after: after)
    if commits&.size&.positive?
      store_commits(repository_id, commits) 
      store_most_recent_commit_id(repository_id, commits.first.id)
    end
    commits
  end

  private

  def store_commits(repository_id, commits)
    key = "scan/#{repository_id}/commits"
    stored_commits = context.key_value_store.fetch(key, [])
    stored_commits.concat(commits)
    context.key_value_store.store(key, stored_commits)
  end
  
  def store_most_recent_commit_id(repository_id, commit_id)
    context.key_value_store.store("scan/#{repository_id}/last_scanned", commit_id)
  end
end
