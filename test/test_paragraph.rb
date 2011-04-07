#!/usr/bin/env ruby
$:.unshift File.join(File.dirname(__FILE__), "../lib")
require 'test_helper'
require 'rafblockparser.tab'

class TestRafBlockParser < Test::Unit::TestCase
  def setup
    @raf = Raf::BlockParser.new
    @single_line_str = "aaa"
    @multi_line_str = <<EOL
aaa bbb ccc
ddd eee fff
EOL
    @multi_block_str = <<EOL
aaa bbb ccc
ddd eee fff

ggg hhh iii
jjj kkk lll
EOL
    
   @single_line_with_inline_elements_str = <<EOL
aaa ((*bbb*)) ((*ccc*))
EOL

   @one_space = <<EOL
 aaa
EOL
  end

  def test_paragraph_is_paragraph
    nodes = @raf.parse(@single_line_str)
    assert_kind_of Raf::Paragraph, nodes[0]
  end

  def test_paragraph_single_line_node_is_plain_text
    nodes = @raf.parse(@single_line_str)
    nodes.each do |node|
      assert_kind_of Raf::Plain, node.contents.first
      assert_kind_of String, node.apply
      assert_equal   node.apply, @single_line_str
    end    
  end

  def test_paragraph_multi_line
    nodes = @raf.parse(@multi_line_str)
    assert_kind_of String, nodes.first.apply
    assert_equal nodes.first.apply, @multi_line_str
  end

  def test_paragraph_multi_block
    nodes = @raf.parse(@multi_block_str)
    assert_equal 3, nodes.size # textblock, whiteline, textblock
    assert_kind_of Raf::Plain,     nodes[0].contents[0]
    assert_kind_of String,         nodes[0].apply
    assert_kind_of Raf::WhiteLine, nodes[1]
    assert_kind_of String,         nodes[1].apply
    assert_kind_of Raf::Plain,     nodes[2].contents[0]
    assert_kind_of String,         nodes[2].apply
  end

  def test_paragraph_with_inline_elements
    # nodes = plain emphasis plain(space) emphasis
    nodes = @raf.parse(@single_line_with_inline_elements_str)
    assert_kind_of Raf::Emphasis, nodes[0].contents[1]
    assert_kind_of Raf::Emphasis, nodes[0].contents[3]
    
    assert_equal "aaa <Emphasis>bbb</Emphasis> <Emphasis>ccc</Emphasis>\n", nodes[0].apply
  end
  
  def test_paragraph_one_space
    res = @raf.parse(@one_space)
    assert_kind_of Raf::Paragraph, res[0]
    assert_equal " aaa\n", res[0].apply
  end
end
