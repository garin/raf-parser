#!/usr/bin/env ruby
$:.unshift File.join(File.dirname(__FILE__), "../lib")
require 'test_helper'
require 'rafblockparser.tab'

class TestRafDescBlock < Test::Unit::TestCase
  def setup
    @raf = Raf::BlockParser.new
    @desc = DescString.new
  end

  def test_desc_is_desc
    nodes = @raf.parse(@desc.single)
    assert_kind_of Raf::Desc, nodes[0]
    assert_kind_of String, nodes[0].contents[0]
    assert_kind_of Array, nodes[0].contents[1]
    assert_kind_of Raf::Plain, nodes[0].contents[1][0]
  end

  def test_desc_multi
    nodes = @raf.parse(@desc.multi)
    assert_kind_of Raf::Desc, nodes[0]
    assert_kind_of String, nodes[0].contents[0]
    assert_kind_of Array, nodes[0].contents[1]
    assert_kind_of Raf::Plain, nodes[0].contents[1][0]
  end

  def test_desc_no_descline
    nodes = @raf.parse(@desc.non_descline)
    assert_kind_of Raf::Desc, nodes[0]
    assert_kind_of String, nodes[0].contents[0]
    assert_kind_of Array, nodes[0].contents[1]
    assert_kind_of Raf::Plain, nodes[0].contents[1][0]
  end

  def test_desc_inline_element
    nodes = @raf.parse(@desc.inline_element)
    assert_kind_of Raf::Desc, nodes[0]
    assert_equal [Raf::Emphasis, Raf::Plain, Raf::Italic, Raf::Plain], nodes[0].contents[1].map {|c| c.class }
  end

  def test_desc_title_only
    res = @raf.parse(@desc.title_only)
    assert_kind_of Raf::Desc, res[0]
    assert_equal ":aaa\n", res[0].apply
  end
end


class DescString
  def single
    <<EOL
:aaa
  bbb
EOL
  end

  def multi
    <<EOL
:aaa
  bbb

  ccc
EOL
  end

  def non_descline
    <<EOL
:aaa

ee
EOL
  end

  def inline_element
    <<EOL
:aaa
  ((*bbb*))
  ((_ccc_))
EOL
  end

  def title_only
    <<EOL
:aaa
EOL
  end
end
