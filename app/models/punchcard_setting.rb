class PunchcardSetting < ApplicationRecord
  belongs_to :company, ->{ where company}
end
