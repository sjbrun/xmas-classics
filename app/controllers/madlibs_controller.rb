class MadlibsController < ApplicationController
  before_action :set_madlib, only: [:show, :edit, :update, :destroy]
  
  def new
    @madlib = Madlib.new
    len = @madlib.song.lyrics.length
    len.times { @madlib.lyrics.build }
  end
  
  def edit
  end
  
  def create
    @madlib = Madlib.new(madlib_params)
    if @madlib.save
      flash[:success] = "Madlib created successfully"
      redirect_to song_madlib_path(@madlib)
    else
      render 'new'
    end
  end
  
  def update
  end
  
  def show
    @lyrics = @song.lines.downcase
    len = @madlib.lyrics.length
    (0..len).each do |n|
       @lyrics.gsub! @song.lyrics.words[n], @madlib.lyrics.words[n]
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
    params.require(:madlib).permit(:one, :two, :three, :four, :five, :six,
                            :seven, :eight, :nine, :ten, :eleven, :twelve)
  end

end
