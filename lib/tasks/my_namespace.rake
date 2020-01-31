require 'json'
require 'open3'

namespace :my_namespace do
  desc "TODO"
  task my_task1: :environment do
    puts "hello gej"
    file = File.read(File.join(ENV['HOME'], 'files_modified.json'))
    data_hash = JSON.parse(file)
    puts data_hash
    stdout, stdeerr, status = Open3.capture3("bundle exec rspec -f j #{data_hash.to_a}")
    output = JSON.pars(stdout)
    output['examples'].each_with_object({}) { |item, obj| obj[item['status']] = obj.fetch(item['status'], []) << item['full_description'] }
  end
end
