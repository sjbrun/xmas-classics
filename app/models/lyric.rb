class Lyric < ActiveRecord::Base
  belongs_to :song
  belongs_to :madlib
  
  validates :word, presence: true
  #validates :part_of_speech, presence: true
end
