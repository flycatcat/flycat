class Punchcard < ApplicationRecord
  # include Slugable
  belongs_to :user

  #Callback
  after_create do
    update(is_punched_in_today: true)
  end
end
