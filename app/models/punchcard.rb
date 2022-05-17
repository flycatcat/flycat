class Punchcard < ApplicationRecord
  # include Slugable
  belongs_to :user

  #Callback
  after_create do
    update(is_first_punchcard_today: false)
  end
end
