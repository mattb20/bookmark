require 'bookmark'

describe Bookmark do
  describe '.all' do
    it 'returns all bookmarks title in an array' do
      Bookmark.create('http://test1.com', 'makersacademy')
      Bookmark.create('http://test2.com', 'destroyallsoftware')
      Bookmark.create('http://test3.com', 'google')

      expected_bookmarks = %w[
        makersacademy
        destroyallsoftware
        google
      ]

      expect(Bookmark.all).to eq expected_bookmarks
    end
  end
  describe '.create' do

    it 'creates a new bookmark' do
      Bookmark.create('http://www.test4.com', 'test4')

      expect(Bookmark.all).to include 'test4'
    end

    it 'does not create a new bookmark if the URL is not valid' do
      Bookmark.create('not a real bookmark', 'not a real title')

      expect(Bookmark.all).not_to include 'not a real bookmark'
    end
  end

  describe'.delete' do
    it 'deletes a bookmark' do
      Bookmark.create('http://www.test10.com', 'test10')
      Bookmark.delete('test10')
      expect(Bookmark.all).not_to include "test10"
    end
  end

  describe '.is_valid_title?' do
    it 'returns true if there is a title ' do
      expect(Bookmark.is_valid_title?('title')).to eq true
    end

    it 'returns false if there is not a title' do
      expect(Bookmark.is_valid_title?('')).to eq false
    end

    it 'returns false if title is longer than 60 chars (database field length)' do
      title = ''
      61.times do title.concat('a') end
      expect(Bookmark.is_valid_title? title).to eq false
    end
  end

  describe '.is_valid_url?' do
    it 'returns true if given a valid URL' do
      @valid_url = ["http://google.com","google.com","mail.google.com","google.co.uk"]
      results = @valid_url.map { |url| Bookmark.is_valid_url?(url) }
      expect(results).to all eq true
    end

    it 'returns false if not given a working URL' do
      #  need to send as it is private method
      expect(Bookmark.is_valid_url?('google')).to eq false
    end

    it 'returns false if URL is too long' do
      
    end
  end

  describe '.validate' do
    before(:all) do
      @valid_bookmark = {:url => "http://google.com", :title => "Google"}
      @invalid_bookmark = {:url => "http://google.com", :title => ""}
    end
    it 'throws an error if not passed a hash' do
      expect{Bookmark.validate('hello')}.to raise_error ArgumentError
    end

    it 'returns false if given an invalid URL or title' do
      expect(Bookmark.validate(@invalid_bookmark)).to eq false
    end

    it 'returns true if passed a valid URL and a valid title' do
      expect(Bookmark.validate(@valid_bookmark)).to eq true
    end
  end

  describe '.manage' do

    it 'returns the string add if bookmark is a unique and valid URL' do

    end

    it 'makes a call to .is_not_duplicate? if given a valid URL and title' do

    end

    it 'if .is_not_duplicate? returns false and it is a duplicate title it returns the string update'  do

    end

    it 'returns add if there is a title and .is_not_duplicate returns true' do

    end

    it 'returns the string create if .is_not_duplicate returns true and ' do

    end
  end
end
# describe '.url' do
#   it 'returns the url in a string form' do
#     Bookmark.create('http://www.test5.com', 'test5')
#     expect(Bookmark.url.last).to eq 'http://www.test5.com'
#   end
# end
