class Song < ActiveRecord::Base
  has_many :madlibs
  has_many :lyrics, -> { order(id: :asc) }
  accepts_nested_attributes_for :lyrics
  
  validates :name, presence: true
  validates :lines, presence: true
end
