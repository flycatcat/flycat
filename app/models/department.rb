class Department < ApplicationRecord

    include Slugable
    
    has_many :staffs
    validates :department_name, presence: true, uniqueness: true

    def normalize_friendly_id(value)
        value.to_s.parameterize(preserve_case: true)
    end
end
