require 'json'
require 'open3'

namespace :my_namespace do
  desc "TODO"
  task my_task1: :environment do
    begin
      file = File.read(File.join(ENV['HOME'], 'files_modified.json'))
      data_hash = JSON.parse(file)
    rescue
      data_hash = [Rails.root]
    end
    puts data_hash

    Open3.capture3("cd #{Rails.root}")
    stdout, stdeerr, status = Open3.capture3("RAILS_ENV=development bundle exec rspec -f j /Users/macos/tweetster-rails-api")

    output = JSON.parse(stdout)
    out = output['examples'].each_with_object({}) { |item, obj| obj[item['status']] = obj.fetch(item['status'], []) << item['full_description'] }
    out.each do |status, group|
      group.each { |g| puts "#{status} - #{g}"}
    end
  end
end
