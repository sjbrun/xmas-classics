class MadlibsController < ApplicationController
  before_action :set_madlib, only: [:show, :edit, :update, :destroy]
  before_action :set_song, only: [:new, :create]
  
  def new
    @madlib = Madlib.new
    @song_lyrics = @song.lyrics.order(id: :asc)
    len = @song.lyrics.length
    (0..len-1).each do |n|
      @madlib.lyrics.build(:part_of_speech => @song_lyrics[n].part_of_speech)
    @madlib.lyrics.reorder(id: :asc)
    end
  end
  
  def edit
  end
  
  def create
    @madlib = Madlib.new(madlib_params)
    @madlib.song = @song
    len = @song.lyrics.length
    (0..len-1).each do |n|
      @madlib.lyrics[n].part_of_speech = @song.lyrics[n].part_of_speech
    end
    if @madlib.save
      flash[:success] = "Madlib created successfully"
      redirect_to song_madlib_path(@song, @madlib)
    else
      render 'new'
    end
  end
  
  def update
    len = @song.lyrics.length
    (0..len-1).each do |n|
      @madlib.lyrics[n].part_of_speech = @song.lyrics[n].part_of_speech
    end
    if @madlib.update(madlib_params)
      flash[:success] = "Madlib was successfully updated."
      redirect_to song_madlib_path(@song, @madlib)
    else
      render 'edit' # render edit tune article page for another try
    end
  end
  
  def show
    @new_lines = @song.lines.downcase
    @song_lyrics = @song.lyrics.order(id: :asc)
    @madlib_lyrics = @madlib.lyrics.order(id: :asc)

    len = @madlib.lyrics.length - 1
    (0..len).each do |n|
      @new_lines.gsub!(
        @song_lyrics[n].word,
        @madlib_lyrics[n].word
      )
    end
    (0..len).each do |n|
      @new_lines.gsub!(
        @madlib_lyrics[n].word,
        "<span class='highlighted'>#{@madlib.lyrics[n].word}</span>"
      )
    end
  end
  
  def index
  end
  
  def destroy
    @madlib.destroy
    flash[:danger] = "Mad lib was successfully deleted."
    redirect_to song_path(@song)
  end
  
  private

  def set_madlib
    @madlib = Madlib.find(params[:id])
    @song = Song.find(params[:song_id])
  end

  def set_song
    @song = Song.find(params[:song_id])
  end

  def madlib_params
    params.require(:madlib).permit(:name, :song_id, 
                  lyrics_attributes: [:id, :word, :part_of_speech])
  end

end
