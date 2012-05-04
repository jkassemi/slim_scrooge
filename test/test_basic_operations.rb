require 'test/unit'
require File.join(File.dirname(__FILE__), '../test/helper')
require File.join(File.dirname(__FILE__), '../test/models/course')

module SlimScrooge
  class Callsites
    ScroogeCallsiteSample = 1..2
  end
end

class TestBasicOperations < Test::Unit::TestCase
  def setup
    SlimScrooge::Callsites.reset
    SlimScrooge::Test.setup

    c = nil

    5.times do |i|
      c = Course.create
    end

    @id = c.id
  end

  def test_all
    assert Course.all.to_a.length == 5
  end

  def test_one
    assert !Course.find(@id).nil?
  end

  def test_first
    assert !Course.first.nil?
  end
  
  def test_where
    courses = Course.where(["id > 0", @id])
    assert courses.count == 5
  end
 
  def test_destroy
    Course.find(@id).destroy
    assert Course.where(:id => @id).count == 0 
  end

  def test_monitoring
    courses = load_all
    names = courses.all.collect(&:name)

    assert callsites_count == 1

    courses = load_all
    ids = courses.all.collect(&:unused)

    assert callsites_count == 1
  end

  private
  def callsites_count
    SlimScrooge::Callsites.count
  end

  def load_all
    Course.where(true)
  end
end
