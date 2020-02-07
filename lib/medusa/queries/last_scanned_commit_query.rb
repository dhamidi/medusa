# frozen_string_literal: true

class LastScannedCommitQuery < BaseQuery
  def call(repository)
    context.key_value_store.fetch("scan/#{repository}/last_scanned")
  end
end
