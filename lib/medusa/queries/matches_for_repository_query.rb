# frozen_string_literal: true

class MatchesForRepositoryQuery < BaseQuery
  def call(repository)
    context.key_value_store.fetch("match/#{repository}", [])
  end
end
