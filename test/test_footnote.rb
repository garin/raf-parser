#!/usr/bin/env ruby
$:.unshift File.join(File.dirname(__FILE__), "../lib")
require 'test_helper'
require 'rafinlineparser.tab'

class TestRafFootnote < Test::Unit::TestCase
  def setup
    @raf = Raf::InlineParser.new
  end

  def test_footnote_is_footnote
    str = '(([aaa]))'
    res = @raf.parse(str)
    assert_kind_of Raf::Footnote, res[0]
    assert_equal '<Footnote>aaa</Footnote>', res[0].apply
    assert_equal "aaa", @raf.index[:footnote][0][:content][0].apply
  end


  def test_footnote_multi
    str = '(([aaa]))(([bbb]))(([ccc]))'
    res = @raf.parse(str)
    assert_kind_of Raf::Footnote, res[0]
    assert_kind_of Raf::Footnote, res[1]
    assert_kind_of Raf::Footnote, res[2]

    assert_equal "aaa", @raf.index[:footnote][0][:content][0].apply
    assert_equal "bbb", @raf.index[:footnote][1][:content][0].apply
    assert_equal "ccc", @raf.index[:footnote][2][:content][0].apply
  end

  def test_footnote_in_element
    str = '(([((*aaa*))]))'
    res = @raf.parse(str)

    assert_equal "<Emphasis>aaa</Emphasis>", @raf.index[:footnote][0][:content][0].apply
  end
end
