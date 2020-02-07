# frozen_string_literal: true

class PstoreKeyValueStore
  def initialize(filename)
    @pstore = PStore.new(filename)
  end

  def clear(pattern = '*')
    pstore.transaction do
      (pstore[:data] || {}).keys.each do |key|
        next unless File.fnmatch(pattern, key.to_s)

        pstore[:data].delete(key)
      end
    end
  end

  def store(key, value)
    pstore.transaction do
      pstore[:data] ||= {}
      pstore[:data][key] = value
    end

    self
  end

  def fetch(key, default = nil, &default_fn)
    pstore.transaction(:read_only) do
      pstore.fetch(:data, {}).fetch(key, default, &default_fn)
    end
  end

  private

  attr_reader :pstore
end
