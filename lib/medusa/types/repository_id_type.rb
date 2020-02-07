# frozen_string_literal: true

class RepositoryIdType < ActiveModel::Type::Value
  def cast_value(value)
    value.to_s
  end

  def assert_valid_value(value)
    # we only allow Github repository IDs, optionally prefixed by
    # github.com
    matches = value.to_s.match(%r{(?:github.com/)?(?<repository_id>[^/]+/[^/]+)})

    valid_values = ['github.com/' + matches[:repository_id], matches[:repository_id]]

    return if valid_values.include?(value)

    raise ArgumentError, "#{value} must be one of #{valid_values}"
  end
end
