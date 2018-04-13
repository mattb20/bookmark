require 'pg'

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

  def self.manage(bookmark)
    # Determines validity and whether create or update
  end

  def self.create(bookmark)
    if validate_url(bookmark[:url]) then
      # Handle updates as updating with same url will result in validate_url returning duplicate error
      # Create bookmark
      return "Bookmark created successfully"
    else 
      return @@message
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
  end
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

  private

  def self.validate_url(url)
    # if valid: return true else false
    if is_url?(url) then
      if is_not_duplicate?(url) then
        return true
      else 
        @@message = "Duplicate URL"
        return false
      end
    end
    @@message = "Invalid url"
    return false
  end

  def self.is_not_duplicate?(url)

  end

  def self.is_url?(url)
    url =~ /\A#{URI.regexp(%w[http https])}\z/
  end

  def self.title?(title)
    if title.length > 0
      return true
    end
  end
end
