# frozen_string_literal: true

module Slugable
  extend ActiveSupport::Concern

  included do
    extend FriendlyId
    friendly_id :random_slug, use: :slugged
  end
  
  def normalize_friendly_id(value)
    value.to_s.parameterize(preserve_case: true)
  end
  private

  def random_slug
    [*'A'..'Z', *'a'..'z', *'0'..'9'].sample(10).join
  end
end
