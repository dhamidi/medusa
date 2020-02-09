# frozen_string_literal: true

class MatchRepositoryAction < BaseAction
  def call(repository)
    record_matches(repository, find_matches(repository))
  end

  private

  def find_matches(repository)
    new_commits = execute(ScanRepositoryAction, repository)
    subscription = query(WatchedRepositoriesQuery).find do |r|
      r.repository == repository
    end
    new_commits.select do |c|
      c.message.include?(subscription.pattern)
    end
  end

  def record_matches(repository, commits)
    matches = context.key_value_store.fetch("match/#{repository}", [])
    context.key_value_store.store(
      "match/#{repository}",
      matches.concat(commits).uniq
    )
  end
end
