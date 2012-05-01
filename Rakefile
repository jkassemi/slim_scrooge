require 'rake'
require 'rake/testtask'
require File.join(File.dirname(__FILE__), 'test/helper')

Rake::TestTask.new(:test_with_active_record) do |t|
  t.libs << SlimScrooge::ActiveRecordTest.active_record_path
  t.libs << SlimScrooge::ActiveRecordTest.connection
  t.test_files = SlimScrooge::ActiveRecordTest.test_files
  t.ruby_opts = ["-r #{File.join(File.dirname(__FILE__), 'test', 'active_record_setup')}"]
  t.verbose = true
end

Rake::TestTask.new(:test) do |t|
  t.test_files = FileList["test/test*.rb"]
  t.verbose = true
  t.warning = true
end
