class Punchcard < ApplicationRecord
  include Slugable
  belongs_to :user

  #Callback
  after_create do
    update(first_punch: false)
  end 
end

