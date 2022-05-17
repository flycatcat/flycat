class Order < ApplicationRecord
    validates :username,  presence: true
    validates :amount, presence: true
end
