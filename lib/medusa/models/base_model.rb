# frozen_string_literal: true

class BaseModel
  include ActiveModel::Model
  include ActiveModel::Attributes

  def ==(other)
    attributes == other.attributes
  end

  def to_s
    attribute_desc = attributes.map do |(name, value)|
      if value.nil?
        ''
      else
        " #{name}=#{value.to_s[0..50].inspect}"
      end
    end
    "#<#{self.class.name}#{attribute_desc.join('')}>"
  end
  alias inspect to_s
end
