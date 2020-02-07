# frozen_string_literal: true

class WatchRepositoryAction < BaseAction
  def call(repository)
    watched = context.key_value_store.fetch('watched_repositories', [])
    watched << repository unless watched.include?(repository)
    context.key_value_store.store('watched_repositories', watched)
  end
end
