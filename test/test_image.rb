#!/usr/bin/env ruby
$:.unshift File.join(File.dirname(__FILE__), "../lib")
require 'test_helper'
require 'rafinlineparser.tab'

class TestRafImage < Test::Unit::TestCase
  def setup
    @raf = Raf::InlineParser.new
  end

  def test_image_is_image
    str = '(($aaa.png$))'
    res = @raf.parse(str)
    assert_kind_of Raf::Strike, res[0]
  end

  def test_image_apply
    str1 = '(($aaa.png$))'    
    res = @raf.parse(str1)
    assert_respond_to res[0], 'apply'
    assert_equal '<Image>aaa.png</Image>', res[0].apply

    str2 = '(($AAA|aaa.png$))'    
    res = @raf.parse(str2)
    assert_respond_to res[0], 'apply'
    assert_equal '<Image>AAA|aaa.png</Image>', res[0].apply
  end

  def test_image_in_element
    str1 = '(($((*aaa*))$))'
    res = @raf.parse(str1)
    assert_kind_of Raf::Image, res[0]
    assert_equal '<Image>((*aaa*))</Image>', res[0].apply

#    str2 = '(($a(($a$))a$))'
#    res = @raf.parse(str2)
#    assert_equal [Raf::Plain, Raf::Image, Raf::Plain], res[0].contents.map {|c| c.class }
#    assert_equal '<Image>a<Image>a</Image>a</Image>', res[0].apply
    
#    str3 = '(($a((*a*))a$))'
#    res = @raf.parse(str3)
#    assert_equal [Raf::Plain, Raf::Emphasis, Raf::Plain], res[0].contents.map {|c| c.class }
#    assert_equal '<Image>a<Emphasis>a</Emphasis>a</Image>', res[0].apply
  end

  def test_image_raise_non_terminate
    str = '(($aaa))'
    assert_raise Racc::ParseError do
      @raf.parse(str)
    end

    str = '(($aaa'
    assert_raise Racc::ParseError do
      @raf.parse(str)
    end
  end

  def test_image_raise_different_terminate
    str = '(($aaa*))'
    assert_raise Racc::ParseError do
      @raf.parse(str)
    end
  end

  def test_image_linefeed
    str1 = <<EOL
(($a
aa$))
EOL
    res = @raf.parse(str1)
    assert_kind_of Raf::Image, res[0]
    assert_equal "<Image>a\naa</Image>", res[0].apply

    str2 = '(($a

aa$))'
    res = @raf.parse(str2)
    assert_kind_of Raf::Image, res[0]
    assert_equal "<Image>a\n\naa</Image>", res[0].apply
  end
end
