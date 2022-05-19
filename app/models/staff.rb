# frozen_string_literal: true

class Staff < ApplicationRecord
  include Slugable
  acts_as_paranoid
  
  belongs_to :company
end
