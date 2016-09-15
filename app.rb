require 'sinatra'
require_relative "isbn_db_app.rb"
require 'pg'
database_params = {
	host: 'joe123.cpdneptoktvs.us-west-2.rds.amazonaws.com',
	port: '5432',
	dbname: 'joe123',
	user: 'joe1mck',
	password: 'bubbadog',
}

db = PG::Connection.new(database_params)

# get '/' do
# 	erb :isbn, :locals => {:validity => "" }
# end	

get '/' do
	select = db.exec("select isbn,validity FROM isbn_numbers ORDER BY validity DESC;")
	    all = select.each do |numbers|
		  numbers["isbn"]
		  numbers["validity"]  
		end
		validity = valid_isbn?(select[0]['isbn'])


	 if validity == false
      db.exec("update isbn_numbers set (validity) = ('Invalid') where isbn = ('#{select[0]['isbn']}');")

		erb :isbn, :locals => {:select => select ,:validity => validity, :all => all}

	 else 
      db.exec("update isbn_numbers set (validity) = ('Valid') where isbn = ('#{select[0]['isbn']}');")
	 	erb :isbn, :locals => {:select => select,:validity => validity, :all => all }
	
	end	
end


post '/add' do
		add_isbn_number = params[:add_isbn_number]

			db.exec("insert into isbn_numbers (isbn) values ('#{add_isbn_number}');")

redirect to '/'
end