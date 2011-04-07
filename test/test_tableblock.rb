#!/usr/bin/env ruby
$:.unshift File.join(File.dirname(__FILE__), "../lib")
require 'test_helper'
require 'rafblockparser.tab'

class TestRafTableBlock < Test::Unit::TestCase
  def setup
    @raf = Raf::BlockParser.new
    @table = TableString.new
  end

  def test_table_is_table
    res = @raf.parse(@table.single)
    assert_kind_of Raf::Table, res[0]
    assert_equal "|aaa|bbb\n|ccc|ddd\n", res[0].apply
  end

  def test_table_with_terminate
    res = @raf.parse(@table.single_with_terminate)
    assert_kind_of Raf::Table, res[0]
    assert_equal "|aaa|bbb\n|ccc|ddd\n", res[0].apply    
  end

  def test_table_with_head
    res = @raf.parse(@table.head)
    assert_kind_of Raf::Table, res[0]
    assert_equal "|*aaa|*bbb\n|ccc|ddd\n", res[0].apply    
  end
  
  def test_table_with_head_and_terminate
    res = @raf.parse(@table.head_with_terminate)
    assert_kind_of Raf::Table, res[0]
    assert_equal "|*aaa|*bbb\n|ccc|ddd\n", res[0].apply    
  end
end

class TableString
  def single
    <<EOL
|aaa|bbb
|ccc|ddd
EOL
  end
  def single_with_terminate
    <<EOL
|aaa|bbb|
|ccc|ddd|
EOL
  end

  def head
    <<EOL
|*aaa|*bbb|
|ccc|ddd|
EOL
  end
  def head_with_terminate
    <<EOL
|*aaa*|*bbb*|
|ccc|ddd|
EOL
  end
end
