#!/usr/bin/env ruby
$:.unshift File.join(File.dirname(__FILE__), "../lib")
require 'test_helper'
require 'rafinlineparser.tab'

class TestRafItalic < Test::Unit::TestCase
  def setup
    @raf = Raf::InlineParser.new
  end

  def test_italic_is_italic
    str = '((_aaa_))'
    res = @raf.parse(str)
    assert_kind_of Raf::Italic, res[0]
  end

  def test_italic_apply
    str = '((_aaa_))'    
    res = @raf.parse(str)
    assert_respond_to res[0], 'apply'
    assert_equal '<Italic>aaa</Italic>', res[0].apply
  end

  def test_italic_in_element
    str1 = '((_((_aaa_))_))'
    res = @raf.parse(str1)
    assert_equal [Raf::Italic], res[0].contents.map {|c| c.class }
    assert_equal '<Italic><Italic>aaa</Italic></Italic>', res[0].apply

    str2 = '((_a((_a_))a_))'
    res = @raf.parse(str2)
    assert_equal [Raf::Plain, Raf::Italic, Raf::Plain], res[0].contents.map {|c| c.class }
    assert_equal '<Italic>a<Italic>a</Italic>a</Italic>', res[0].apply
    
    str3 = '((_a((*a*))a_))'
    res = @raf.parse(str3)
    assert_equal [Raf::Plain, Raf::Emphasis, Raf::Plain], res[0].contents.map {|c| c.class }
    assert_equal '<Italic>a<Emphasis>a</Emphasis>a</Italic>', res[0].apply
  end

  def test_italic_raise_non_terminate
    str = '((_aaa))'
    assert_raise Racc::ParseError do
      @raf.parse(str)
    end

    str = '((_aaa'
    assert_raise Racc::ParseError do
      @raf.parse(str)
    end
  end

  def test_italic_raise_different_terminate
    str = '((_aaa*))'
    assert_raise Racc::ParseError do
      @raf.parse(str)
    end
  end

  def test_italic_linefeed
    str1 = <<EOL
((_a
aa_))
EOL
    res = @raf.parse(str1)
    assert_kind_of Raf::Italic, res[0]
    assert_equal "<Italic>a\naa</Italic>", res[0].apply

    str2 = '((_a

aa_))'
    res = @raf.parse(str2)
    assert_kind_of Raf::Italic, res[0]
    assert_equal "<Italic>a\n\naa</Italic>", res[0].apply
  end
end
