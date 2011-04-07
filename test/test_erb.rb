#!/usr/bin/env ruby
$:.unshift File.join(File.dirname(__FILE__), "../lib")
require 'test_helper'
require 'rafinlineparser.tab'

class TestRafErb < Test::Unit::TestCase
  def setup
    @raf = Raf::InlineParser.new
  end

  def test_erb_is_erb
    str = "<%= 'aaa' %>"
    res = @raf.parse(str)
    assert_kind_of Raf::Plain, res[0]
    assert_equal "aaa", res[0].apply
  end

  def test_erb_variable
    str = "<%= val = 'aaa' ; val %>"
    res = @raf.parse(str)
    assert_equal "aaa", res[0].apply
  end
end
