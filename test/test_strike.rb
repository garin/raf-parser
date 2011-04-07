#!/usr/bin/env ruby
$:.unshift File.join(File.dirname(__FILE__), "../lib")
require 'test_helper'
require 'rafinlineparser.tab'

class TestRafStrike < Test::Unit::TestCase
  def setup
    @raf = Raf::InlineParser.new
  end

  def test_strike_is_strike
    str = '((-aaa-))'
    res = @raf.parse(str)
    assert_kind_of Raf::Strike, res[0]
  end

  def test_strike_apply
    str = '((-aaa-))'    
    res = @raf.parse(str)
    assert_respond_to res[0], 'apply'
    assert_equal '<Strike>aaa</Strike>', res[0].apply
  end

  def test_strike_in_element
    str1 = '((-((-aaa-))-))'
    res = @raf.parse(str1)
    assert_equal [Raf::Strike], res[0].contents.map {|c| c.class }
    assert_equal '<Strike><Strike>aaa</Strike></Strike>', res[0].apply

    str2 = '((-a((-a-))a-))'
    res = @raf.parse(str2)
    assert_equal [Raf::Plain, Raf::Strike, Raf::Plain], res[0].contents.map {|c| c.class }
    assert_equal '<Strike>a<Strike>a</Strike>a</Strike>', res[0].apply
    
    str3 = '((-a((*a*))a-))'
    res = @raf.parse(str3)
    assert_equal [Raf::Plain, Raf::Emphasis, Raf::Plain], res[0].contents.map {|c| c.class }
    assert_equal '<Strike>a<Emphasis>a</Emphasis>a</Strike>', res[0].apply
  end

  def test_strike_raise_non_terminate
    str = '((-aaa))'
    assert_raise Racc::ParseError do
      @raf.parse(str)
    end

    str = '((-aaa'
    assert_raise Racc::ParseError do
      @raf.parse(str)
    end
  end

  def test_strike_raise_different_terminate
    str = '((-aaa*))'
    assert_raise Racc::ParseError do
      @raf.parse(str)
    end
  end

  def test_strike_linefeed
    str1 = <<EOL
((-a
aa-))
EOL
    res = @raf.parse(str1)
    assert_kind_of Raf::Strike, res[0]
    assert_equal "<Strike>a\naa</Strike>", res[0].apply

    str2 = '((-a

aa-))'
    res = @raf.parse(str2)
    assert_kind_of Raf::Strike, res[0]
    assert_equal "<Strike>a\n\naa</Strike>", res[0].apply
  end
end
