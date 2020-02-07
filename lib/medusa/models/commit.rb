# frozen_string_literal: true

class Commit < BaseModel
  attribute :id, :sha1
  attribute :message, :string
end
