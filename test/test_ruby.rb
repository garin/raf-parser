#!/usr/bin/env ruby
$:.unshift File.join(File.dirname(__FILE__), "../lib")
require 'test_helper'
require 'rafinlineparser.tab'

class TestRafRuby < Test::Unit::TestCase
  def setup
    @raf = Raf::InlineParser.new
  end

  def test_ruby_is_ruby
    str = '((^AAA|aaa^))'
    res = @raf.parse(str)
    assert_kind_of Raf::Ruby, res[0]
    assert_equal ["AAA","aaa"], res[0].contents
    assert_equal '<Ruby>Base:AAA,Text:aaa</Ruby>', res[0].apply
  end

  def test_ruby_base_only
    str = '((^AAA|^))'
    res = @raf.parse(str)
    assert_kind_of Raf::Ruby, res[0]
    assert_equal '<Ruby>Base:AAA,Text:</Ruby>', res[0].apply

    str2 = '((^AAA^))'
    res = @raf.parse(str2)
    assert_kind_of Raf::Ruby, res[0]
    assert_equal '<Ruby>Base:AAA,Text:AAA</Ruby>', res[0].apply    
  end
  
  def test_ruby_text_only
    str = '((^|aaa^))'
    res = @raf.parse(str)
    assert_kind_of Raf::Ruby, res[0]
    assert_equal '<Ruby>Base:,Text:aaa</Ruby>', res[0].apply
  end

  def test_ruby_in_element
    str1 = '((^((*AAA*))|aaa^))'
    res = @raf.parse(str1)
    assert_equal '<Ruby>Base:((*AAA*)),Text:aaa</Ruby>', res[0].apply
    
    str2 = '((*aaa|((^AAA|bbb^))*))'
    res = @raf.parse(str2)
    assert_equal '<Emphasis>aaa|<Ruby>Base:AAA,Text:bbb</Ruby></Emphasis>', res[0].apply
  end

  def test_emphasis_raise_non_terminate
    str = '((^aaa))'
    assert_raise Racc::ParseError do
      @raf.parse(str)
    end

    str = '((^aaa'
    assert_raise Racc::ParseError do
      @raf.parse(str)
    end
  end

  def test_emphasis_raise_different_terminate
    str = '((^aaa-))'
    assert_raise Racc::ParseError do
      @raf.parse(str)
    end
  end  
end
