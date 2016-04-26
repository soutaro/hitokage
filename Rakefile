require "bundler/gem_tasks"
require "rake/testtask"
require "rake/extensiontask"

Rake::TestTask.new(:test) do |t|
  t.libs << "test"
  t.libs << "lib"
  t.test_files = FileList['test/**/*_test.rb']
end

Rake::ExtensionTask.new "hitokage_ext" do |ext|
  ext.lib_dir = "lib/hitokage"
end

task :benchmark do |t|
  sh "ruby -I lib test/benchmark.rb"
end

task :default => :spec
