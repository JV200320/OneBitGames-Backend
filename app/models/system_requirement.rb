class SystemRequirement < ApplicationRecord
  validates :name, presence: true, uniqueness: {case_sensitive: false}
  validates :os, presence: true
  validates :memory, presence: true
  validates :processor, presence: true
  validates :storage, presence: true
  validates :video_board, presence: true

  has_many :games, dependent: :restrict_with_error

  include NameSearchable
  include Paginatable
end
