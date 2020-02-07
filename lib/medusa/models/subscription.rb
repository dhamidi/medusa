# frozen_string_literal: true

class Subscription < BaseModel
  attribute :repository, :repository_id
  attribute :pattern, :string
end
