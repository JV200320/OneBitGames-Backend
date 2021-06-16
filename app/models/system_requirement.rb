class SystemRequirement < ApplicationRecord
  validates :name, presence: true, uniqueness: {case_sensitive: false}
  validates :os, presence: true
  validates :memory, presence: true
  validates :processor, presence: true
  validates :storage, presence: true
  validates :video_board, presence: true

  has_many :games, dependent: :destroy

  include NameSearchable
  include Paginatable
end
