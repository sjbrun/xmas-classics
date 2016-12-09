class Madlib < ActiveRecord::Base
  belongs_to :song
  has_many :lyrics, dependent: :destroy
  accepts_nested_attributes_for :lyrics
end
