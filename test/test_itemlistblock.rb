#!/usr/bin/env ruby
$:.unshift File.join(File.dirname(__FILE__), "../lib")
require 'test_helper'
require 'rafblockparser.tab'

class TestRafItemListBlock < Test::Unit::TestCase
  def setup
    @raf = Raf::BlockParser.new
    @itemlist = ListString.new
  end

  def test_list_is_list
    nodes = @raf.parse(@itemlist.single)
    assert_kind_of Raf::ItemList, nodes[0]
  end

  def test_list_is_plain_text_block
    nodes = @raf.parse(@itemlist.single)
    assert_kind_of Raf::ItemList, nodes[0]
    assert_equal [Raf::PlainTextBlock],  nodes[0].contents.map {|n| n.class }
    assert_equal "<ItemList><ItemListItem>aaa</ItemListItem></ItemList>", nodes[0].apply
  end

  def test_list_multi_line
    nodes = @raf.parse(@itemlist.multi)
    assert_kind_of Raf::ItemList, nodes[0]
    assert_equal [Raf::PlainTextBlock, Raf::PlainTextBlock],  nodes[0].contents.map {|n| n.class }
    assert_equal "<ItemList><ItemListItem>aaa</ItemListItem><ItemListItem>bbb</ItemListItem></ItemList>",  nodes[0].apply
  end

  def test_list_nest
    nodes = @raf.parse(@itemlist.nest)
    assert_kind_of Raf::ItemList, nodes[0]
    assert_equal [Raf::PlainTextBlock, Symbol, Raf::PlainTextBlock, Symbol],  nodes[0].contents.map {|n| n.class }
    assert_equal "<ItemList><ItemListItem>aaa</ItemListItem><INDENT/><ItemListItem>bbb</ItemListItem><DEDENT/></ItemList>",  nodes[0].apply
  end

  def test_list_nest_and_unnest
    nodes = @raf.parse(@itemlist.nest_and_unnest_multi_line)
    assert_kind_of Raf::ItemList, nodes[0]
    assert_equal [Raf::PlainTextBlock, Symbol, Raf::PlainTextBlock, Raf::PlainTextBlock, Symbol, Raf::PlainTextBlock, Raf::PlainTextBlock, Symbol, Raf::PlainTextBlock, Symbol, Symbol, Raf::PlainTextBlock, Symbol, Raf::PlainTextBlock], nodes[0].contents.map {|n| n.class }
    assert_equal "<ItemList><ItemListItem>aaa</ItemListItem><INDENT/><ItemListItem>bbb</ItemListItem><ItemListItem>ccc</ItemListItem><INDENT/><ItemListItem>ddd</ItemListItem><ItemListItem>eee</ItemListItem><INDENT/><ItemListItem>fff</ItemListItem><DEDENT/><DEDENT/><ItemListItem>ggg</ItemListItem><DEDENT/><ItemListItem>hhh</ItemListItem></ItemList>", nodes[0].apply    
  end
  
  def test_list_with_inline_element
    nodes = @raf.parse(@itemlist.inline_element)
    assert_kind_of Raf::ItemList, nodes[0]
    assert_equal [Raf::PlainTextBlock, Raf::PlainTextBlock, Raf::PlainTextBlock], nodes[0].contents.map {|n| n.class }
    assert_kind_of Raf::Emphasis, nodes[0].contents[0].contents[1]
    assert_equal "<ItemList><ItemListItem>aaa<Emphasis>AAA</Emphasis></ItemListItem><ItemListItem>bbb</ItemListItem><ItemListItem><Italic>ccc</Italic></ItemListItem></ItemList>", nodes[0].apply    
  end

  def test_list_multi_block
    nodes = @raf.parse(@itemlist.multi_block)
    assert_equal 3, nodes.size  # [itemblock, whiteline, itemblock]
    assert_kind_of Raf::ItemList, nodes[0]
    assert_kind_of Raf::ItemList, nodes[2]
    assert_equal [Raf::PlainTextBlock,Raf::PlainTextBlock], nodes[0].contents.map {|n| n.class }   
    assert_equal [Raf::PlainTextBlock,Raf::PlainTextBlock], nodes[2].contents.map {|n| n.class }
    assert_equal "<ItemList><ItemListItem>aaa</ItemListItem><ItemListItem>bbb</ItemListItem></ItemList>", nodes[0].apply    
    assert_equal "<ItemList><ItemListItem>ccc</ItemListItem><ItemListItem>ddd</ItemListItem></ItemList>", nodes[2].apply
  end

  def test_list_with_br
    nodes = @raf.parse(@itemlist.with_br)
    assert_equal "<ItemList><ItemListItem>aaa\nbbb</ItemListItem></ItemList>", nodes[0].apply
    assert_equal "<ItemList><ItemListItem>aaa</ItemListItem></ItemList>", nodes[2].apply
    assert_equal "bbb", nodes[4].apply    
  end

  def test_list_and_quote
    nodes = @raf.parse(@itemlist.and_quote)
    assert_kind_of Raf::ItemList, nodes[0]
    assert_kind_of Raf::WhiteLine, nodes[1]
    assert_kind_of Raf::Quote, nodes[2]
  end
end

class ListString
  def single
    "* aaa"
  end

  def multi
    <<EOL
* aaa
* bbb
EOL
  end

  def nest
    <<EOL
* aaa
  * bbb
EOL
  end
  
  def nest_and_unnest_multi_line
    <<EOL
* aaa
  * bbb
  * ccc
    * ddd
    * eee
      * fff
  * ggg
* hhh
EOL
  end

  def inline_element
    <<EOL
* aaa((*AAA*))
* bbb
* ((_ccc_))
EOL
  end

  def multi_block
    <<EOL
* aaa
* bbb

* ccc
* ddd
EOL
  end

  def and_quote
    <<EOL
* aaa
* bbb

  ccc
  ddd
EOL
  end

  # 空行がなればリスト、あれば引用
  def with_br
    <<EOL
* aaa
  bbb

* aaa

  bbb
EOL
  end
end

