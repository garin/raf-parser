#!/usr/bin/env ruby
$:.unshift File.join(File.dirname(__FILE__), "../lib")
require 'test_helper'
require 'rafblockparser.tab'

class TestRafQuoteBlock < Test::Unit::TestCase

  def setup
    @raf = Raf::BlockParser.new
    @quote = QuoteString.new
  end

  def test_quote_is_quote
    nodes = @raf.parse(@quote.single)
    assert_kind_of Raf::Quote, nodes[0]
    assert_equal delete_indent(@quote.single),  nodes[0].apply
  end

  def test_quote_multi
    nodes = @raf.parse(@quote.multi)
    assert_equal nodes.size, 1, "ホワイトリストがあっても1ブロック"   # [quote]
    assert_kind_of Raf::Quote, nodes[0]
    assert_equal delete_indent(@quote.multi),  nodes[0].apply
  end

  def test_quote_inline_element
    nodes = @raf.parse(@quote.inline_element)
    assert_kind_of Raf::Quote, nodes[0]
    # インラインエレメントは変換しないでそのまま
    assert_equal delete_indent(@quote.inline_element),  nodes[0].apply
  end

  def test_quote_multi_indent
    nodes = @raf.parse(@quote.multi_indent)
    assert_kind_of Raf::Quote, nodes[0]
    # インデントを無視する
    assert_equal "aaa\n  bbb\n       ccc\n    ddd\nfff", nodes[0].apply
  end

  def test_quote_space
    res1 = @raf.parse(@quote.space)
    assert_kind_of Raf::Quote, res1[0]
    assert_equal "aaa\nbbb",res1[0].apply

    res2 = @raf.parse(@quote.space2)
    assert_kind_of Raf::Quote, res2[0]
    assert_equal "aaa\nbbb",res2[0].apply
  end

  def delete_indent(str)
    str.map {|s| s.sub(/^  /, "") }.to_s.strip
  end
end


class QuoteString
  def single
    <<EOL
  aaa
  bbb
EOL
  end

  def multi
    <<EOL
  aaa
  bbb

  ccc
  ddd
EOL
  end

  def inline_element
    <<EOL
  ((*aaa*))
  ((_bbb_))
EOL
  end

  def multi_indent
    <<EOL
  aaa
    bbb
         ccc
      ddd
  fff
EOL
  end

  def space
    <<EOL
  aaa
  bbb

ccc
EOL
  end

  def space2
    <<EOL
  aaa
  bbb


ccc
EOL
  end
end
