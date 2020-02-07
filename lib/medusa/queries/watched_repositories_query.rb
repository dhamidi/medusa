# frozen_string_literal: true

class WatchedRepositoriesQuery < BaseQuery
  def call
    context.key_value_store.fetch('watched_repositories', [])
  end
end
