class Coupon < ApplicationRecord
  validates :code, :due_date, :status, :discount_value, presence: true
  validates :discount_value, numericality: {greater_than: 0}
  enum status: {active: 1, inactive: 2}
  validates :code, uniqueness: {case_sensitive: false}
end
