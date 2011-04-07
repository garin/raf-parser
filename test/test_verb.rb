#!/usr/bin/env ruby
$:.unshift File.join(File.dirname(__FILE__), "../lib")
require 'test_helper'
require 'rafinlineparser.tab'

class TestRafVerb < Test::Unit::TestCase
  def setup
    @raf = Raf::InlineParser.new
  end

  def test_verb_is_verb
    str = "(('aaa'))"
    res = @raf.parse(str)
    assert_kind_of Raf::Verb, res[0]
    assert_equal ["aaa"], res[0].contents
    assert_equal '<Verb>aaa</Verb>', res[0].apply
  end

  def test_verb_in_emphasis
    str = "(('((*aaa*))'))"
    res = @raf.parse(str)
    assert_kind_of Raf::Verb, res[0]
    assert_equal '<Verb>((*aaa*))</Verb>', res[0].apply
    
    str = "(('((*aaa))'))"
    res = @raf.parse(str)
    assert_kind_of Raf::Verb, res[0]
    assert_equal '<Verb>((*aaa))</Verb>', res[0].apply    
  end

  def test_verb_in_italic
    str = "(('((_aaa_))'))"
    res = @raf.parse(str)
    assert_kind_of Raf::Verb, res[0]
    assert_equal '<Verb>((_aaa_))</Verb>', res[0].apply
  end

  def test_verb_in_strike
    str = "(('((-aaa-))'))"
    res = @raf.parse(str)
    assert_kind_of Raf::Verb, res[0]
    assert_equal '<Verb>((-aaa-))</Verb>', res[0].apply
  end    

  def test_verb_in_ruby
    str = "(('((^aaa^))'))"
    res = @raf.parse(str)
    assert_kind_of Raf::Verb, res[0]
    assert_equal '<Verb>((^aaa^))</Verb>', res[0].apply
  end

  def test_verb_in_footnote
    str = "(('(([aaa]))'))"
    res = @raf.parse(str)
    assert_kind_of Raf::Verb, res[0]
    assert_equal '<Verb>(([aaa]))</Verb>', res[0].apply
  end    

  def test_verb_in_image
    str = "(('(($aaa$))'))"
    res = @raf.parse(str)
    assert_kind_of Raf::Verb, res[0]
    assert_equal '<Verb>(($aaa$))</Verb>', res[0].apply
  end    

  def test_verb_in_reference
    str = "(('((<aaa>))'))"
    res = @raf.parse(str)
    assert_kind_of Raf::Verb, res[0]
    assert_equal '<Verb>((<aaa>))</Verb>', res[0].apply
  end    

  def test_verb_in_manuedo
    str = "(('((/aaa/))'))"
    res = @raf.parse(str)
    assert_kind_of Raf::Verb, res[0]
    assert_equal '<Verb>((/aaa/))</Verb>', res[0].apply
  end    

  def test_verb_in_erb
    str = "(('<%= aaa %>'))"
    res = @raf.parse(str)
    assert_kind_of Raf::Verb, res[0]
    assert_equal '<Verb><%= aaa %></Verb>', res[0].apply
  end    
end
