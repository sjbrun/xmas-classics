class LyricsController < ApplicationController
  default_scope { order(id: :asc) }
  before_action :set_lyric, only: [:show, :edit, :update, :destroy]
  
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
  
  def destroy
    @lyric.destroy
  end
  
  private
  
  def set_lyric
    @lyric = Lyric.find(params[:id])
  end

  def lyric_params
    params.require(:lyric).permit(:word, :part_of_speech, :song_id,
                                  :madlib_id)
  end
  
end
