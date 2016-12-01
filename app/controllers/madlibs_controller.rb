class MadlibsController < ApplicationController
  before_action :set_madlib, only: [:show, :edit, :update, :destroy]
  
  def new
    @madlib = Madlib.new
    #len = @madlib.song.lyrics.length
    #len.times { @madlib.lyrics.build }
    12.times { @madlib.lyrics.build }
  end
  
  def edit
  end
  
  def create
    @madlib = Madlib.new(madlib_params)
    if @madlib.save
      flash[:success] = "Madlib created successfully"
      redirect_to madlib_path(@madlib)
    else
      render 'new'
    end
  end
  
  def update
  end
  
  def show
    @new_lyrics = @song.lines.downcase
    len = @madlib.lyrics.length - 1
    (0..len).each do |n|
      @new_lyrics.gsub!(@song.lyrics[n].word, @madlib.lyrics[n].word)
    end
  end
  
  def index
  end
  
  def delete
  end
  
  
  private

  def set_madlib
    @madlib = Madlib.find(params[:id])
    @song = @madlib.song
  end

  def madlib_params
    params.require(:madlib).permit(:song_id, 
                  lyrics_attributes: [:id, :word, :part_of_speech])
  end

end
