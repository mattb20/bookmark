require 'pg'
require 'URI'

class Bookmark
  def self.all
    if ENV['RACK_ENV'] == 'test'
      connection = PG.connect(dbname: 'bookmark_manager_test')
    else
      connection =  PG.connect(dbname: 'bookmark_manager')
    end
    result = connection.exec('SELECT * FROM bookmarks')
    result.map { |bookmark| bookmark['title'] }
  end
  def self.display
    if ENV['RACK_ENV'] == 'test'
      connection =  PG.connect(dbname: 'bookmark_manager_test')
    else
      connection = PG.connect(dbname: 'bookmark_manager')
    end
    result = connection.exec('SELECT * FROM bookmarks')
    result.map { |bookmark| "<a href=" + bookmark['url'] + ">" + bookmark['title'] + "</a>" + "<input type='submit' value = Delete" + " name = " + bookmark['title'] + ">" }
  end

    # return false unless is_url?(link) && title?(title)
    # if ENV['RACK_ENV'] == 'test'
    #     connection = PG.connect(dbname: 'bookmark_manager_test')
    # else
    #   connection =  PG.connect(dbname: 'bookmark_manager')
    # end
    # result = connection.exec('SELECT * FROM bookmarks')
    # url_list = result.map { |bookmark| bookmark['url'] }
    # if url_list.include?(link)
    #   connection.exec "UPDATE bookmarks SET title = '#{title}' WHERE url = '#{link}'"
    # else
    #   connection.exec("INSERT INTO bookmarks(url, title) VALUES('#{link}', '#{title}')")
    # end

    # result = connection.exec('SELECT * FROM bookmarks')
  def self.url
    if ENV['RACK_ENV'] == 'test'
      connection = PG.connect(dbname: 'bookmark_manager_test')
    else
      connection = PG.connect(dbname: 'bookmark_manager')
    end
    result = connection.exec('SELECT * FROM bookmarks')
    result.map { |bookmark| bookmark['url'] }
  end

  def self.delete(title)
    if ENV['RACK_ENV'] == 'test'
      connection = PG.connect(dbname: 'bookmark_manager_test')
    else
      connection = PG.connect(dbname: 'bookmark_manager')
    end
      connection.exec("DELETE FROM BOOKMARKS WHERE title = '#{title}'")

  end

  def self.manage(bookmark)
    # Determines validity and whether create or update
    # If bookmark is valid:
  end

  def self.create(bookmark)
    if validate(bookmark[:url]) then
      # Handle updates as updating with same url will result in validate_url returning duplicate error
      # Create bookmark
      return "Bookmark created successfully"
    else
      return @@message
    end
  end

  def self.is_duplicate?(url)

  end

  def self.validate(bookmark)
    if bookmark.class != Hash then
      raise ArgumentError, 'Hash is not being passed in'
    end
    if is_valid_url?(bookmark[:url]) && is_valid_title?(bookmark[:title]) then
      return true
    else
      return false
    end
  end

  def self.is_valid_url?(url)
    url =~ /\A#{URI.regexp(%w[http https])}\z/ ? true : false
  end

  def self.is_valid_title?(title)
    return title.length > 0 && title.length <= 60 ? true : false
  end

end
