class Lyric < ActiveRecord::Base
  belongs_to :song, dependent: :destroy
  belongs_to :madlib, dependent: :destroy
  
  validates :word, presence: true
  #validates :part_of_speech, presence: true
end
