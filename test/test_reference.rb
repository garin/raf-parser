#!/usr/bin/env ruby
$:.unshift File.join(File.dirname(__FILE__), "../lib")
require 'test_helper'
require 'rafinlineparser.tab'

class TestRafReference < Test::Unit::TestCase
  def setup
    @raf = Raf::InlineParser.new
  end

  def test_reference_is_reference
    res = @raf.parse('((<aaa>))')
    assert_kind_of Raf::Reference, res[0]
  end
  
  def test_reference_label_only
    str = '((<aaa>))'
    res = @raf.parse(str)
    assert_kind_of Raf::Reference, res[0]
    assert_equal "aaa", res[0].contents[0]  # title
    assert_equal "#" + "aaa".to_code, res[0].contents[1]  # label
  end
  
  def test_reference_title_and_label
    str = '((<aaa|hoge>))'
    res = @raf.parse(str)
    assert_kind_of Raf::Reference, res[0]
    assert_equal "aaa", res[0].contents[0]  # title
    assert_equal "#" + "hoge".to_code, res[0].contents[1]  # label
  end
  
  def test_reference_uri_only
    str = '((<http://example.com>))'
    res = @raf.parse(str)
    assert_kind_of Raf::Reference, res[0]
    assert_equal "http://example.com", res[0].contents[0]  # title
    assert_equal "http://example.com", res[0].contents[1]  # label
  end
  
  def test_reference_title_and_uri
    str = '((<aaa|http://example.com>))'
    res = @raf.parse(str)
    assert_kind_of Raf::Reference, res[0]
    assert_equal "aaa", res[0].contents[0]  # title
    assert_equal "http://example.com", res[0].contents[1]  # label    
  end  
end
