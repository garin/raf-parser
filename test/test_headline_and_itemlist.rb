#!/usr/bin/env ruby
$:.unshift File.join(File.dirname(__FILE__), "../lib")
require 'test_helper'
require 'rafblockparser.tab'

class TestRafHeadLine < Test::Unit::TestCase
  def setup
    @raf = Raf::BlockParser.new
    @hi = StringHeadLineItemlist.new

  end

  def test_headline_is_headline
    res = @raf.parse(@hi.single)
    #assert_kind_of Raf::HeadLine, res[0]
    p res.size
    puts "4 is error"    
#     p res[0].contents
#     p res[1].contents
#     p res[2].contents
#    p res[3].contents

  end

end


class StringHeadLineItemlist
  def single
    <<EOL
== aaa
aaa

* list
  
=== bbb
BBB
EOL
  end
end
