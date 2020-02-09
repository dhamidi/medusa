# frozen_string_literal: true

class DashboardQuery < BaseQuery
  class Subscription < BaseModel
    attribute :repository, :string
    attribute :pattern, :string
    attribute :last_scanned, :string
    attribute :matches

    def last_scanned
      super || 'unknown'
    end
  end

  def call
    WatchedRepositoriesQuery.new(context).call.map do |subscription|
      result = Subscription.new(subscription.attributes)
      result.last_scanned = LastScannedCommitQuery.new(context).call(
        result.repository
      )
      result.matches = MatchesForRepositoryQuery.new(context).call(
        result.repository
      )
      result
    end
  end
end
