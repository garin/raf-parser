#!/usr/bin/env ruby
$:.unshift File.join(File.dirname(__FILE__), "../lib")
require 'test_helper'
require 'rafinlineparser.tab'

class TestRafEmphasis < Test::Unit::TestCase
  def setup
    @raf = Raf::InlineParser.new
  end

  def test_emphasis_is_emphasis
    str = '((*aaa*))'
    res = @raf.parse(str)
    assert_kind_of Raf::Emphasis, res[0]
  end

  def test_emphasis_apply
    str = '((*aaa*))'    
    res = @raf.parse(str)
    assert_respond_to res[0], 'apply'
    assert_equal '<Emphasis>aaa</Emphasis>', res[0].apply
  end

  def test_emphasis_in_element
    str1 = '((*((_aaa_))*))'
    res = @raf.parse(str1)
    assert_equal [Raf::Italic], res[0].contents.map {|c| c.class }
    assert_equal '<Emphasis><Italic>aaa</Italic></Emphasis>', res[0].apply

    str2 = '((*a((*a*))a*))'
    res = @raf.parse(str2)
    assert_equal [Raf::Plain, Raf::Emphasis, Raf::Plain], res[0].contents.map {|c| c.class }
    assert_equal '<Emphasis>a<Emphasis>a</Emphasis>a</Emphasis>', res[0].apply
    
    str3 = '((*a((_a_))a*))'
    res = @raf.parse(str3)
    assert_equal [Raf::Plain, Raf::Italic, Raf::Plain], res[0].contents.map {|c| c.class }
    assert_equal '<Emphasis>a<Italic>a</Italic>a</Emphasis>', res[0].apply
  end

  def test_emphasis_raise_non_terminate
    str = '((*aaa))'
    assert_raise Racc::ParseError do
      @raf.parse(str)
    end

    str = '((*aaa'
    assert_raise Racc::ParseError do
      @raf.parse(str)
    end
  end

  def test_emphasis_raise_different_terminate
    str = '((*aaa-))'
    assert_raise Racc::ParseError do
      @raf.parse(str)
    end
  end

  def test_emphasis_linefeed
    str = <<EOL
((*a
aa*))
EOL
    res = @raf.parse(str)
    assert_kind_of Raf::Emphasis, res[0]
    assert_equal "<Emphasis>a\naa</Emphasis>", res[0].apply

    str = '((*a

aa*))'
    res = @raf.parse(str)
    assert_kind_of Raf::Emphasis, res[0]
    assert_equal "<Emphasis>a\n\naa</Emphasis>", res[0].apply
  end
end
