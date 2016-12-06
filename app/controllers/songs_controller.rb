class SongsController < ApplicationController
  before_action :set_song, only: [:show, :edit, :update, :destroy]

  def new
    @available_audio = get_available_songs

    @song = Song.new
    4.times { @song.lyrics.build }
  end

  def create
    song_params[:audio] = "/assets/#{song_params[:audio]}"
    @song = Song.new(song_params)
    @song.lyrics.each do |lyric|
      lyric.word.downcase!
    end
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
    @available_audio = get_available_songs
  end
  
  def update
    if @song.update(song_params)
      flash[:success] = "Song was successfully updated."
      redirect_to song_path(@song)
    else
      render 'edit' # render edit tune article page for another try
    end
  end
  
  def delete
  end
  
  private

  SONGS_ON_S3 = [
    "01---Blue-Christmas--Originally-Performed-by-Elvis-Presley---Karaoke-Version.mp3",
    "01---Rockin'-Around-The-Christmas-Tree--As-Made-Famous-by-Brenda-Lee---Karaoke-Version-.mp3",
    "02---Jingle-Bell-Rock--As-Made-Famous-by-Bobby-Helms---Karaoke-Version-.mp3",
    "02---Little-Saint-Nick--Originally-Performed-by-the-Beach-Boys---Karaoke-Version-.mp3",
    "03---Angels-We-Have-Heard-On-High--As-Made-Famous-by-Various-Artists---Karaoke-Version-.mp3",
    "03---Rockin'-Around-the-Christmas-Tree--Originally-Performed-by-Tony-Bennett---Karaoke-Version-.mp3",
    "04---Go-Tell-It-on-the-Mountain--Originally-Performed-by-Simon-_-Garfunkel---Karaoke-Version-.mp3",
    "05---All-I-Want-For-Christmas-Is-You--As-Made-Famous-by-Mariah-Carey---Karaoke-Version-.mp3",
    "05---Deck-the-Halls--Originally-Performed-by-Frank-Sinatra---Karaoke-Version-.mp3",
    "05---It%27s-Beginning-To-Look-A-Lot-Like-Christmas--As-Made-Famous-by-Perry-Como---Karaoke-Version-.mp3",
    "05---It%27s-The-Most-Wonderful-Time-Of-The-Year--As-Made-Famous-by-Andy-Williams---Karaoke-Version-.mp3",
    "06---Grandma-Got-Run-over-by-a-Reindeer--Originally-Performed-by-Elmo-N%27-Patsy---Karaoke-Version-.mp3",
    "07---Last-Christmas--As-Made-Famous-by-Wham!---Karaoke-Version-.mp3",
    "07---Silent-Night--Karaoke-Version-.mp3",
    "08---Feliz-Navidad--Originally-Performed-by-Jose-Feliciano---Karaoke-Version-.mp3",
    "09---Rudolph-the-Red-Nosed-Reindeer--Originally-Performed-by-Frank-Sinatra---Karaoke-Version-.mp3",
    "10---All-I-Want-for-Christmas-Is-You--Originally-Performed-by-Justin-Bieber-_-Mariah-Carey---Karaoke-Version-.mp3",
    "11---Jingle-Bells--Originally-Performed-by-Frank-Sinatra---Karaoke-Version-.mp3",
    "12---Holly-Jolly-Christmas--Originally-Performed-by-Burl-Ives---Karaoke-Version-.mp3",
    "13---Santa-Baby--Originally-Performed-by-Madonna---Karaoke-Version-.mp3",
    "14---Have-Yourself-a-Merry-Little-Christmas--Originally-Performed-by-Frank-Sinatra---Karaoke-Version-.mp3",
    "15---White-Christmas--Originally-Performed-by-Bing-Crosby---Karaoke-Version-.mp3",
    "16---Santa-Claus-Is-Comin%27-to-Town--Originally-Performed-by-Bruce-Springsteen---Karaoke-Version-.mp3",
    "17---Wonderful-Christmastime--Originally-Performed-by-Paul-Mccartney---Karaoke-Version-.mp3",
    "18---Tennessee-Christmas--Originally-Performed-by-Amy-Grant---Karaoke-Version-.mp3",
    "19---Christmas-Lights--Originally-Performed-by-Coldplay---Karaoke-Version-.mp3",
    "20---It%27s-Beginning-to-Look-a-Lot-Like-Christmas--Originally-Performed-by-Dean-Martin---Karaoke-Version-.mp3",
    "21---Do-They-Know-It%27s-Christmas--Originally-Performed-by-Band-Aid---Karaoke-Version-.mp3",
    "22---Silver-Bells--Originally-Performed-by-Bing-Crosby---Karaoke-Version-.mp3",
    "23---Welcome-Christmas--Originally-Performed-by-the-Glee-Cast---Karaoke-Version-.mp3",
    "24---Jingle-Bell-Rock--Originally-Performed-by-Bobby-Helms---Karaoke-Version-.mp3",
    "25---Christmas-Tree--Originally-Performed-by-Lady-Gaga---Karaoke-Version-.mp3",
    "26---Last-Christmas--Originally-Performed-by-Wham---Karaoke-Version-.mp3",
    "27---Twelve-Days-of-Christmas--Originally-Performed-by-Tony-Bennett---Karaoke-Version-.mp3",
    "28---Winter-Wonderland--Originally-Performed-by-Perry-Como---Karaoke-Version-.mp3",
    "29---It%27s-the-Most-Wonderful-Time-of-the-Year--Originally-Performed-by-Andy-Williams---Karaoke-Version-.mp3",
    "30---O-Come-All-Ye-Faithful--Originally-Performed-by-Elvis-Presley---Karaoke-Version-.mp3",
    "31---December-Song--Originally-Performed-by-George-Michael---Karaoke-Version-.mp3",
    "32---Christmas-Day--Originally-Performed-by-Dido---Karaoke-Version-.mp3",
    "33---Once-Upon-a-Christmas-Song--Originally-Performed-by-Peter-Kay---Karaoke-Version-.mp3",
    "34---Do-You-Hear-What-I-Hear--Originally-Performed-by-Frank-Sinatra---Karaoke-Version-.mp3",
    "35---Christmas-Time-Is-Here--From-_A-Charlie-Brown-Christmas_---Karaoke-Version-.mp3",
    "36---Please-Come-Home-for-Christmas--Originally-Performed-by-Bon-Jovi---Karaoke-Version-.mp3",
    "37---Sleigh-Ride--Originally-Performed-by-the-Ronettes---Karaoke-Version-.mp3",
    "38---I%27ll-Be-Home-for-Christmas--Originally-Performed-by-Frank-Sinatra---Karaoke-Version-.mp3",
    "39---What-Child-Is-This_--Originally-Performed-by-Johnny-Mathis---Karaoke-Version-.mp3",
    "40---Mistletoe--Originally-Performed-by-Justin-Bieber---Karaoke-Version-.mp3",
    "41---Happy-Christmas--Originally-Performed-by-John-Lennon---Karaoke-Version-.mp3",
    "42---Little-Drummer-Boy--Originally-Performed-by-David-Bowie-_-Bing-Crosby---Karaoke-Version-.mp3",
    "43---Mary-Did-You-Know--Originally-Performed-by-Helen-Cornelius---Karaoke-Version-.mp3",
  ]

  S3_PREFIX = "https://s3-us-west-2.amazonaws.com/xmas-classics/audio/"

  def get_available_songs
    SONGS_ON_S3.map do |s|
      "#{S3_PREFIX}#{s}"
    end
  end

  def set_song
    @song = Song.find(params[:id])
  end

  def song_params
    params.require(:song).permit(:name, :lines, :audio, lyrics_attributes: [:id, :word, :part_of_speech])
  end

end
