# taken from http://github.com/olauzon/active-record-rake-populate-csv/tree/master/populate.rake
# populate_data.rake
# usage: rake db:populate RAILS_ENV=test
# alternate Rails ActiveRecord model fixtures loading and data seeding using csv files with FasterCSV
# this file goes in "lib/tasks/databases/populate.rake" or similar
# you create a "db/populate" directory where you put csv files
# each csv file is named following the "table_name.csv" convention
# for example, to load data into an "Address" ActiveRecord model (in an "addresses" database table) use an "addresses.csv" filename
# the csv files must have a header row with exact attribute names
namespace :db do
  desc 'Populate the database defined in config/database.yml for the current RAILS_ENV'
  task :populate => :environment do
    populate_database
  end
 
  def populate_database
    require 'pp'
    require 'fastercsv'
    csv_populate_dir = RAILS_ROOT + '/db/populate'
    FileList["#{csv_populate_dir}/*.csv"].each do |csv|
      table_name = File.basename(csv, ".csv")
      model_class = table_name.classify.constantize
      if model_class.table_exists?
        model_class.connection.execute("TRUNCATE #{model_class.table_name}")
        FasterCSV.foreach(csv, {:headers => :first_row}) do |row|
          object = model_class.new
          object_attributes = Hash.new
          row.each do |d|
            column_name = d[0]
            value = d[1]
            unless value.nil?
              object_attributes[column_name] = value if model_class.column_names.include?(column_name)
              object.send("#{column_name}=".to_sym, value)
            end
          end
          object.save! unless model_class.exists?(object_attributes)
          pp object
        end
      end
    end
  end
end