require 'pg'



connection = PG.connect(dbname: 'bookmark_manager_test')

connection.exec('TRUNCATE bookmarks RESTART IDENTITY;')
