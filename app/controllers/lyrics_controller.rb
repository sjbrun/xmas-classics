class LyricsController < ApplicationController
  #before_action :set_lyric, only: [:show, :edit, :update, :destroy]
  
  def new
  end

  def create
  end
  
  def index
  end
  
  def show
  end
  
  def edit
  end
  
  def update
  end
  
  def delete
  end
  
  private
  
  def set_song
    @lyric = Lyric.find(params[:id])
  end

  def lyric_params
    params.require(:lyric).permit(:word, :part_of_speech, :song_id)
  end
  
end
