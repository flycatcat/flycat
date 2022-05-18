class Punchcard < ApplicationRecord
  include Slugable
  belongs_to :user

  #Callback
  # before_save do
  #   if @lastpunch == true
  #     @punchcard.save
  #   end
  # end

  after_create do
    update(first_punch: false)
  end 
end

