class SongsController < ApplicationController
  before_action :set_song, only: [:show, :edit, :update, :destroy]
  
  def new
    @song = Song.new
    12.times { @song.lyrics.build }
  end

  def create
    @song = Song.new(song_params)
    if @song.save
      flash[:success] = "Song created successfully"
      redirect_to song_path(@song)
    else
      render 'new'
    end
  end
  
  def index
    @songs = Song.all
  end
  
  def show
    @original_lines = @song.lines
    
  end
  
  def edit
  end
  
  def update
  end
  
  def delete
  end
  
  private
  
  def set_song
    @song = Song.find(params[:id])
  end

  def song_params
    params.require(:song).permit(:name, :lines, lyrics_attributes: [:id, :word, :part_of_speech])
  end

end
