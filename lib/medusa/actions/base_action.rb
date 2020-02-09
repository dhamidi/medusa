# frozen_string_literal: true

class BaseAction
  def initialize(context)
    @context = context
  end

  def self.async(context, params)
    Thread.new do
      new(context).call(params)
    end
  end

  def query(query_class, *params)
    query_class.new(context).call(*params)
  end

  def execute(action_class, *params)
    action_class.new(context).call(*params)
  end

  attr_reader :context
end
