class Punchcard < ApplicationRecord
  # include Slugable
  belongs_to :user

  #Callback


  # before_save do
  #   if is_first_punchcard_today == false?
  #   update(punch_in_out: Time.current)
  #   after_save_method
  # end
  
  after_create do
    update(is_first_punchcard_today: false)
    if is_first_punchcard_today
      update(punch_in_at: Time.current)
    end
  end
end

