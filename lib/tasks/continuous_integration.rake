# require "#{RAILS_ROOT}/lib/build_settings"
# include BuildSettings

rspec_base = File.expand_path("#{RAILS_ROOT}/vendor/plugins/rspec/lib")
$LOAD_PATH.unshift(rspec_base) if File.exist?(rspec_base)
require 'spec/rake/spectask'

namespace :hudson do
  
  desc "Task to do some preparations for Hudson"
  task :prepare do
    RAILS_ENV = ENV['RAILS_ENV'] = 'test'
  end
  
  desc "Task for Hudson"
  task :spec => ["hudson:prepare", "db:migrate"] do
    ENV['SPEC_OPTS'] = "--format specdoc --loadby mtime --reverse"
    Rake::Task['hudson:coverage'].invoke 
  end

  desc "Run specs and rcov"
  Spec::Rake::SpecTask.new(:coverage) do |t|
    t.rcov = true
    t.rcov_opts = ['--exclude', 'spec,/usr/lib/ruby,/Library/Ruby/,lib/authenticated_system.rb,lib/authenticated_test_helper.rb,lib/migrations/import.rb,lib/tasks/fake_extensions.rb', '--rails', '--text-report']
    t.spec_files = FileList['spec/**/*_spec.rb']
  end
  
end
