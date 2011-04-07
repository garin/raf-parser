#!/usr/bin/env ruby
$:.unshift File.join(File.dirname(__FILE__), "../lib")
require 'test_helper'
require 'rafblockparser.tab'

class TestRafHeadLine < Test::Unit::TestCase
  def setup
    @raf = Raf::BlockParser.new
    @headline = StringHeadLine.new
  end

  def test_headline_is_headline
    res = @raf.parse(@headline.single)
    assert_kind_of Raf::HeadLine, res[0]

  end

  def test_headline_all
    res = @raf.parse(@headline.all)

  end
end


class StringHeadLine
  def single
    <<EOL
= title
EOL
  end

  def all
    <<EOL
= head1
== head2
=== head3
==== head4
+ head5
++ head6
EOL
    
  end
end
