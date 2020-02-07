# frozen_string_literal: true

class DashboardQuery < BaseQuery
  class Subscription
    include ActiveModel::Model
    include ActiveModel::Attributes

    attribute :repository, :string
    attribute :pattern, :string
    attribute :last_scanned, :string

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
      result
    end
  end
end
