# frozen_string_literal: true

class BaseAction
  def initialize(context)
    @context = context
  end
  attr_reader :context
end
