# frozen_string_literal: true

class UnwatchRepositoryAction < BaseAction
  def call(repository)
    watched_repositories = query(WatchedRepositoriesQuery)
    watched_repositories.filter! { |s| s.repository != repository }
    context.key_value_store.store('watched_repositories', watched_repositories)
  end
end
