require 'json'
namespace :my_namespace do
  desc "TODO"
  task my_task1: :environment do
    puts "hello gej"
    file = File.read(File.join(ENV['HOME'], 'files_modified.json'))
    data_hash = JSON.parse(file)
    puts data_hash
  end
end
