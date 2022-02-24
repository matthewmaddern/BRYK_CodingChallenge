class Good < ApplicationRecord
  validates :cosignment_id, presence: true, uniqueness: true
  validates :good_type, presence: true
  validates :name, presence: true
  validates :source, presence: true
  validates :destination, presence: true
  validates :entry_time, presence: true
end
