# frozen_string_literal: true

class Sha1Type < ActiveModel::Type::Value
  def cast_value(v)
    return v if looks_like_sha1?(v)

    ::Digest::SHA1.hexdigest(v.to_s)
  end

  private

  def looks_like_sha1?(v)
    v.is_a?(String) && v.match?(/^[0-9][a-f]{40}$/)
  end
end
