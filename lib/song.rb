require 'pry'

class Song
  attr_accessor :name, :artist_name
  @@all = []

  def self.all
    @@all
  end

  def save
    self.class.all << self
  end
  
  def self.create
    song = self.new
    song.save
    song
  end
  
  def self.new_by_name(song_name)
    song = self.new
    song.name = song_name
    song
  end
  
  def self.create_by_name(song_name)
    song = self.new_by_name(song_name)
    song.save
    song
  end
  
  def self.find_by_name(song_name)
    self.all.detect{ |song| song.name == song_name }
  end
  
  def self.find_or_create_by_name(song_name)
    song = self.find_by_name(song_name)
    #If song is truthy then return song otherwise create the song object and return it
    song ? song : self.create_by_name(song_name)
  end
  
  def self.alphabetical
    self.all.sort{ |song1, song2|  song1.name <=> song2.name }
  end
  
  def self.new_from_filename(filename)
    
    #split the string by the period "." symbol and take the first element in that array to 
    #remove the trailing "".mp3".  Next split it again by the hyphon so we're left with an array
    #where the first element is the artist and the second is the song name
    
    song_details = filename.split(".")[0].split("-")
    song = self.new_by_name(song_details[1].strip)
    song.artist_name = song_details[0].strip
    song
  end
  
  def self.create_from_filename(filename)
    song = self.new_from_filename(filename)
    song.save
    song
  end
  
  def self.destroy_all
    self.all.clear
  end

end
