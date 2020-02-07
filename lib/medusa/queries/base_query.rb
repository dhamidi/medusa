# frozen_string_literal: true

class BaseQuery
  def initialize(context)
    @context = context
  end
  attr_reader :context
end

