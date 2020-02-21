require 'json'
require 'open3'

TEST_RESULT_FILE = File.join(ENV['HOME'], 'difference.txt')

def branch_name
  ENV['GITHUB_REF'] && ENV['GITHUB_REF'].split('/')[2]
end

def modified_files
  `git diff-tree --name-only --no-commit-id master #{branch_name}`.split("\n")
end

def files_to_run_tests_on
  puts "Moddified files #{modified_files}"
  modified_files.map do |file|
    next if !file.end_with?('.rb')

    if file.end_with?('_spec.rb')
      file
    else
      if file.star_with?('app/') && file.end_with?('.rb')
        candidate = File.join('spec', file[3..-4]) + '_spec.rb'
      end
    end
  end.compact
end

def run_tests(files)
  puts "running tests on #{files}"
  stdout, stdeerr, status = Open3.capture3("RAILS_ENV=development bundle exec rspec -f j #{files.join(' ')}")

  output = JSON.parse(stdout)
  out = output['examples'].each_with_object({}) { |item, obj| obj[item['status']] = obj.fetch(item['status'], []) << item['full_description'] }
  out
end

def first_master_run
  puts 'First run!'
  out = run_tests(files_to_run_tests_on)
  File.open(TEST_RESULT_FILE, 'w') do |f|
    f.write(out.to_json)
  end
end

def second_branch_run
  puts 'Second run!'
  begin
    master_output = JSON.parse(File.read(TEST_RESULT_FILE))
  rescue
    puts 'Commited directly to master? :/'
    raise
  end
  File.delete(TEST_RESULT_FILE)

  master_failed = master_output["failed"].to_a
  this_failed = run_tests(files_to_run_tests_on)["failed"].to_a

  diff = this_failed - master_failed

  puts diff
  if diff != []
    diff.each { |g| puts "FAILLL!!! - #{g}"}
    raise "DUPA KAMIENI KUPA"
  end
end

namespace :my_namespace do
  desc "TODO"
  task my_task1: :environment do
    if branch_name == 'master'
      first_master_run
    else
      second_branch_run
    end
  end
end
