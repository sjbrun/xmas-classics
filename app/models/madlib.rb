class Madlib < ActiveRecord::Base
  belongs_to :song
  has_many :lyrics, -> { order(id: :asc) }, dependent: :destroy
  accepts_nested_attributes_for :lyrics
end
