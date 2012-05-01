require 'test/unit'
require File.join(File.dirname(__FILE__), '../test/helper')
require File.join(File.dirname(__FILE__), '../test/models/course')

class TestBasicOperations < Test::Unit::TestCase
  def setup
    SlimScrooge::Test.setup

    c = nil

    5.times do |i|
      c = Course.create
    end

    @id = c.id
  end

  def test_all
    Course.all.to_a
  end

  def test_one
    puts @id
    puts Course.all.inspect

    assert !Course.find(@id.to_s).nil?
  end

  def test_first
    Course.first
  end
  
  def test_where
    courses = Course.where(["id > 0", @id])
    assert courses.count == 5
  end
  
  def test_destroy
    Course.first.destroy
  end

  def test_monitoring
    courses = load_all
    names = courses.all.collect(&:name)

    courses = load_all.all
  end

  private
  def load_all
    Course.where(true)
  end
end
