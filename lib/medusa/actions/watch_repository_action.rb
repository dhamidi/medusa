# frozen_string_literal: true

class WatchRepositoryAction < BaseAction
  def call(repository, pattern)
    subscription = Subscription.new(
      repository: repository,
      pattern: pattern
    )
    watched = context.key_value_store.fetch('watched_repositories', [])

    add_or_update(watched, subscription)

    context.key_value_store.store('watched_repositories', watched)
  end

  private

  def add_or_update(watched, new_subscription)
    existing_subscription = watched.find do |s|
      s.repository == new_subscription.repository
    end

    if existing_subscription
      existing_subscription.pattern = new_subscription.pattern
    else
      watched << new_subscription
    end
  end
end
