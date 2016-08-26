desc "Seed the database with dummy data"
namespace :db do
  task :seed_dummy_data => :environment do
    load(File.join(Rails.root, 'db', 'dummy_data_seeds.rb'))
  end
end
