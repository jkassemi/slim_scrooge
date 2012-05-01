require File.join(File.dirname(__FILE__), 'setup')
require 'active_support/test_case'
require 'logger'

active_record_spec = Gem::Specification.find_by_name("activerecord")
active_record_path = active_record_spec.gem_dir
$LOAD_PATH << File.join(active_record_path, "test")

module SlimScrooge
  class Test
    class << self
      def setup
        setup_constants
        make_sqlite_config
        make_sqlite_connection
        load_models
        load(SCHEMA_ROOT + "/schema.rb")
        require 'test/unit'
      end

      def test_files
        glob("#{File.dirname(__FILE__)}/**/*_test.rb")
      end

      def test_model_files
        %w{course}
      end

      private

      def setup_constants
        set_constant('TEST_ROOT') {File.expand_path(File.dirname(__FILE__))}
        set_constant('SCHEMA_ROOT') {TEST_ROOT + "/schema"}
      end
      
      def make_sqlite_config
        ActiveRecord::Base.configurations = {
          'db' => {
            :adapter => 'sqlite3',
            :database => ':memory:',
            :timeout => 5000
          }
        }
      end
      
      def load_models
        test_model_files.each {|f| require File.join(File.dirname(__FILE__), "models", f)}
      end

      def make_sqlite_connection
        ActiveRecord::Base.establish_connection(ActiveRecord::Base.configurations['db'])
        ActiveRecord::Base.logger = Logger.new(STDERR)
      end
      
      def set_constant(constant)
        Object.const_set(constant, yield) unless Object.const_defined?(constant)
      end
      
      def glob(pattern)
        Dir.glob(pattern)
      end
    end
  end
  
  class ActiveRecordTest < Test
    class << self
      def setup
        setup_constants
      end
      
      def test_files
        (glob("#{active_record_path}/test/cases/**/*_test.rb").reject { |x|
          x =~ /\/adapters\//
        } + Dir.glob("test/cases/adapters/sqlite3/**/*_test.rb")).sort
      end

      def active_record_path
        active_record_spec = Gem::Specification.find_by_name("activerecord")
        active_record_spec.gem_dir
      end

      def connection
        File.join(active_record_path, 'connections', 'native_mysql')
      end
    end
  end
end
