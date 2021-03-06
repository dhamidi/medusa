# frozen_string_literal: true

class Sha1Type < ActiveModel::Type::Value
  def cast_value(value)
    return value if looks_like_sha1?(value)

    puts "digest(#{value.inspect}) => #{::Digest::SHA1.hexdigest(value.to_s)}"
    ::Digest::SHA1.hexdigest(value.to_s)
  end

  private

  def looks_like_sha1?(value)
    value.is_a?(String) && value.match?(/^[0-9a-f]{40}$/)
  end
end
