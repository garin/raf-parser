#!/usr/bin/env ruby
$:.unshift File.join(File.dirname(__FILE__), "../lib")
require 'test_helper'
require 'rafblockparser.tab'

class TestRafNumListBlock < Test::Unit::TestCase
  def setup
    @raf = Raf::BlockParser.new
    @numlist1 = NumlistString1.new
    @numlist2 = NumlistString2.new
    @numlistmix = NumlistStringMix.new
  end

  def test_numlist_is_numlist
    res1 = @raf.parse(@numlist1.single)
    assert_kind_of Raf::NumList, res1[0]

    res2 = @raf.parse(@numlist2.single)
    assert_kind_of Raf::NumList, res2[0]
    
    res3 = @raf.parse(@numlistmix.single)
    assert_kind_of Raf::NumList, res3[0]    
  end

  def test_numlist_is_plain_text_block
    res1 = @raf.parse(@numlist1.single)
    assert_kind_of Raf::NumList, res1[0]
    assert_equal [Raf::PlainTextBlock],  res1[0].contents.map {|n| n.class }
    assert_equal "<NumList><NumListItem>1. aaa</NumListItem></NumList>", res1[0].apply

    res2 = @raf.parse(@numlist2.single)
    assert_kind_of Raf::NumList, res2[0]
    assert_equal [Raf::PlainTextBlock],  res2[0].contents.map {|n| n.class }
    assert_equal "<NumList><NumListItem>1. aaa</NumListItem></NumList>", res2[0].apply

    res3 = @raf.parse(@numlistmix.single)
    assert_kind_of Raf::NumList, res3[0]
    assert_equal [Raf::PlainTextBlock],  res3[0].contents.map {|n| n.class }
    assert_equal "<NumList><NumListItem>1. aaa</NumListItem></NumList>", res3[0].apply
  end
 
   def test_numlist_multi_line
     res1 = @raf.parse(@numlist1.multi)
     assert_kind_of Raf::NumList, res1[0]
     assert_equal [Raf::PlainTextBlock, Raf::PlainTextBlock],  res1[0].contents.map {|n| n.class }
     assert_equal "<NumList><NumListItem>1. aaa</NumListItem><NumListItem>2. bbb</NumListItem></NumList>",  res1[0].apply

     res2 = @raf.parse(@numlist2.multi)
     assert_kind_of Raf::NumList, res2[0]
     assert_equal [Raf::PlainTextBlock, Raf::PlainTextBlock],  res2[0].contents.map {|n| n.class }
     assert_equal "<NumList><NumListItem>1. aaa</NumListItem><NumListItem>2. bbb</NumListItem></NumList>",  res2[0].apply

     res3 = @raf.parse(@numlistmix.multi)
     assert_kind_of Raf::NumList, res3[0]
     assert_equal [Raf::PlainTextBlock, Raf::PlainTextBlock],  res3[0].contents.map {|n| n.class }
     assert_equal "<NumList><NumListItem>1. aaa</NumListItem><NumListItem>2. bbb</NumListItem></NumList>",  res3[0].apply
   end

  def test_numlist_nest
    res1 = @raf.parse(@numlist1.nest)
    assert_kind_of Raf::NumList, res1[0]
    assert_equal [Raf::PlainTextBlock, Symbol, Raf::PlainTextBlock, Symbol],  res1[0].contents.map {|n| n.class }
    assert_equal "<NumList><NumListItem>1. aaa</NumListItem><INDENT/><NumListItem>2. bbb</NumListItem><DEDENT/></NumList>",  res1[0].apply

    res2 = @raf.parse(@numlist2.nest)
    assert_kind_of Raf::NumList, res2[0]
    assert_equal [Raf::PlainTextBlock, Symbol, Raf::PlainTextBlock, Symbol],  res2[0].contents.map {|n| n.class }
    assert_equal "<NumList><NumListItem>1. aaa</NumListItem><INDENT/><NumListItem>2. bbb</NumListItem><DEDENT/></NumList>",  res2[0].apply

    res3 = @raf.parse(@numlistmix.nest)
    assert_kind_of Raf::NumList, res3[0]
    assert_equal [Raf::PlainTextBlock, Symbol, Raf::PlainTextBlock, Symbol],  res3[0].contents.map {|n| n.class }
    assert_equal "<NumList><NumListItem>1. aaa</NumListItem><INDENT/><NumListItem>2. bbb</NumListItem><DEDENT/></NumList>",  res3[0].apply
  end

  def test_numlist_nest_and_unnest
    res1 = @raf.parse(@numlist1.nest_and_unnest_multi_line)
    assert_kind_of Raf::NumList, res1[0]
    assert_equal [Raf::PlainTextBlock, Symbol, Raf::PlainTextBlock, Raf::PlainTextBlock, Symbol, Raf::PlainTextBlock, Raf::PlainTextBlock, Symbol, Raf::PlainTextBlock, Symbol, Symbol, Raf::PlainTextBlock, Symbol, Raf::PlainTextBlock], res1[0].contents.map {|n| n.class }
    assert_equal "<NumList><NumListItem>1. aaa</NumListItem><INDENT/><NumListItem>2. bbb</NumListItem><NumListItem>3. ccc</NumListItem><INDENT/><NumListItem>4. ddd</NumListItem><NumListItem>5. eee</NumListItem><INDENT/><NumListItem>6. fff</NumListItem><DEDENT/><DEDENT/><NumListItem>7. ggg</NumListItem><DEDENT/><NumListItem>8. hhh</NumListItem></NumList>", res1[0].apply

    res2 = @raf.parse(@numlist2.nest_and_unnest_multi_line)
    assert_kind_of Raf::NumList, res2[0]
    assert_equal [Raf::PlainTextBlock, Symbol, Raf::PlainTextBlock, Raf::PlainTextBlock, Symbol, Raf::PlainTextBlock, Raf::PlainTextBlock, Symbol, Raf::PlainTextBlock, Symbol, Symbol, Raf::PlainTextBlock, Symbol, Raf::PlainTextBlock], res2[0].contents.map {|n| n.class }
    assert_equal "<NumList><NumListItem>1. aaa</NumListItem><INDENT/><NumListItem>2. bbb</NumListItem><NumListItem>3. ccc</NumListItem><INDENT/><NumListItem>4. ddd</NumListItem><NumListItem>5. eee</NumListItem><INDENT/><NumListItem>6. fff</NumListItem><DEDENT/><DEDENT/><NumListItem>7. ggg</NumListItem><DEDENT/><NumListItem>8. hhh</NumListItem></NumList>", res2[0].apply

    res3 = @raf.parse(@numlistmix.nest_and_unnest_multi_line)
    assert_kind_of Raf::NumList, res3[0]
    assert_equal [Raf::PlainTextBlock, Symbol, Raf::PlainTextBlock, Raf::PlainTextBlock, Symbol, Raf::PlainTextBlock, Raf::PlainTextBlock, Symbol, Raf::PlainTextBlock, Symbol, Symbol, Raf::PlainTextBlock, Symbol, Raf::PlainTextBlock], res3[0].contents.map {|n| n.class }
    assert_equal "<NumList><NumListItem>1. aaa</NumListItem><INDENT/><NumListItem>2. bbb</NumListItem><NumListItem>3. ccc</NumListItem><INDENT/><NumListItem>4. ddd</NumListItem><NumListItem>5. eee</NumListItem><INDENT/><NumListItem>6. fff</NumListItem><DEDENT/><DEDENT/><NumListItem>7. ggg</NumListItem><DEDENT/><NumListItem>8. hhh</NumListItem></NumList>", res3[0].apply    
  end

  def test_numlist_with_inline_element
    res1 = @raf.parse(@numlist1.inline_element)
    assert_kind_of Raf::NumList, res1[0]
    assert_equal [Raf::PlainTextBlock, Raf::PlainTextBlock, Raf::PlainTextBlock], res1[0].contents.map {|n| n.class }
    assert_kind_of Raf::Emphasis, res1[0].contents[0].contents[1]
    assert_equal "<NumList><NumListItem>1. aaa<Emphasis>AAA</Emphasis></NumListItem><NumListItem>2. bbb</NumListItem><NumListItem>3. <Italic>ccc</Italic></NumListItem></NumList>", res1[0].apply    

    res2 = @raf.parse(@numlist2.inline_element)
    assert_kind_of Raf::NumList, res2[0]
    assert_equal [Raf::PlainTextBlock, Raf::PlainTextBlock, Raf::PlainTextBlock], res2[0].contents.map {|n| n.class }
    assert_kind_of Raf::Emphasis, res2[0].contents[0].contents[1]
    assert_equal "<NumList><NumListItem>1. aaa<Emphasis>AAA</Emphasis></NumListItem><NumListItem>2. bbb</NumListItem><NumListItem>3. <Italic>ccc</Italic></NumListItem></NumList>", res2[0].apply    

    res3 = @raf.parse(@numlistmix.inline_element)
    assert_kind_of Raf::NumList, res3[0]
    assert_equal [Raf::PlainTextBlock, Raf::PlainTextBlock, Raf::PlainTextBlock], res3[0].contents.map {|n| n.class }
    assert_kind_of Raf::Emphasis, res3[0].contents[0].contents[1]
    assert_equal "<NumList><NumListItem>1. aaa<Emphasis>AAA</Emphasis></NumListItem><NumListItem>2. bbb</NumListItem><NumListItem>3. <Italic>ccc</Italic></NumListItem></NumList>", res3[0].apply    
  end
 
  def test_numlist_multi_block
    res1 = @raf.parse(@numlist1.multi_block)
    assert_equal 3, res1.size  # [itemblock, whiteline, itemblock]
    assert_kind_of Raf::NumList, res1[0]
    assert_kind_of Raf::NumList, res1[2]
    assert_equal [Raf::PlainTextBlock,Raf::PlainTextBlock], res1[0].contents.map {|n| n.class }   
    assert_equal [Raf::PlainTextBlock,Raf::PlainTextBlock], res1[2].contents.map {|n| n.class }
    assert_equal "<NumList><NumListItem>1. aaa</NumListItem><NumListItem>2. bbb</NumListItem></NumList>", res1[0].apply    
    assert_equal "<NumList><NumListItem>1. ccc</NumListItem><NumListItem>2. ddd</NumListItem></NumList>", res1[2].apply

    res2 = @raf.parse(@numlist2.multi_block)
    assert_equal 3, res2.size  # [itemblock, whiteline, itemblock]
    assert_kind_of Raf::NumList, res2[0]
    assert_kind_of Raf::NumList, res2[2]
    assert_equal [Raf::PlainTextBlock,Raf::PlainTextBlock], res2[0].contents.map {|n| n.class }   
    assert_equal [Raf::PlainTextBlock,Raf::PlainTextBlock], res2[2].contents.map {|n| n.class }
    assert_equal "<NumList><NumListItem>1. aaa</NumListItem><NumListItem>2. bbb</NumListItem></NumList>", res2[0].apply    
    assert_equal "<NumList><NumListItem>1. ccc</NumListItem><NumListItem>2. ddd</NumListItem></NumList>", res2[2].apply

    res3 = @raf.parse(@numlistmix.multi_block)
    assert_equal 3, res3.size  # [itemblock, whiteline, itemblock]
    assert_kind_of Raf::NumList, res3[0]
    assert_kind_of Raf::NumList, res3[2]
    assert_equal [Raf::PlainTextBlock,Raf::PlainTextBlock], res3[0].contents.map {|n| n.class }   
    assert_equal [Raf::PlainTextBlock,Raf::PlainTextBlock], res3[2].contents.map {|n| n.class }
    assert_equal "<NumList><NumListItem>1. aaa</NumListItem><NumListItem>2. bbb</NumListItem></NumList>", res3[0].apply    
    assert_equal "<NumList><NumListItem>1. ccc</NumListItem><NumListItem>2. ddd</NumListItem></NumList>", res3[2].apply
  end

  def test_numlist_and_quote
    res1 = @raf.parse(@numlist1.and_quote)
    assert_kind_of Raf::NumList, res1[0]
    assert_kind_of Raf::WhiteLine, res1[1]
    assert_kind_of Raf::Quote, res1[2]

    res2 = @raf.parse(@numlist2.and_quote)
    assert_kind_of Raf::NumList, res2[0]
    assert_kind_of Raf::WhiteLine, res2[1]
    assert_kind_of Raf::Quote, res2[2]

    res3 = @raf.parse(@numlistmix.and_quote)
    assert_kind_of Raf::NumList, res3[0]
    assert_kind_of Raf::WhiteLine, res3[1]
    assert_kind_of Raf::Quote, res3[2]
 end
end

class NumlistString1
  def single
    "(1) aaa"
  end

  def multi
    <<EOL
(1) aaa
(2) bbb
EOL
  end

  def nest
    <<EOL
(1) aaa
  (1) bbb
EOL
  end
  
  def nest_and_unnest_multi_line
    <<EOL
(1) aaa
  (2) bbb
  (3) ccc
    (4) ddd
    (5) eee
      (6) fff
  (7) ggg
(8) hhh
EOL
  end

  def inline_element
    <<EOL
(1) aaa((*AAA*))
(2) bbb
(3) ((_ccc_))
EOL
  end

  def multi_block
    <<EOL
(1) aaa
(2) bbb

(3) ccc
(4) ddd
EOL
  end

  def and_quote
    <<EOL
(1) aaa
(2) bbb

  ccc
  ddd
EOL
  end

end

class NumlistString2
  def single
    "1. aaa"
  end

  def multi
    <<EOL
1. aaa
2. bbb
EOL
  end

  def nest
    <<EOL
1. aaa
  1. bbb
EOL
  end
  
  def nest_and_unnest_multi_line
    <<EOL
1. aaa
  2. bbb
  3. ccc
    4. ddd
    5. eee
      6. fff
  7. ggg
8. hhh
EOL
  end

  def inline_element
    <<EOL
1. aaa((*AAA*))
2. bbb
3. ((_ccc_))
EOL
  end

  def multi_block
    <<EOL
1. aaa
2. bbb

3. ccc
4. ddd
EOL
  end

  def and_quote
    <<EOL
1. aaa
2. bbb

  ccc
  ddd
EOL
  end
end

class NumlistStringMix
  def single
    "1. aaa"
  end

  def multi
    <<EOL
(1) aaa
2. bbb
EOL
  end

  def nest
    <<EOL
(1) aaa
  2. bbb
EOL
  end
  
  def nest_and_unnest_multi_line
    <<EOL
1. aaa
  (2) bbb
  3. ccc
    (4) ddd
    (5) eee
      6. fff
  7. ggg
(8) hhh
EOL
  end

  def inline_element
    <<EOL
1. aaa((*AAA*))
(2) bbb
3. ((_ccc_))
EOL
  end

  def multi_block
    <<EOL
1. aaa
2. bbb

(3) ccc
4. ddd
EOL
  end

  def and_quote
    <<EOL
1. aaa
(2) bbb

  ccc
  ddd
EOL
  end
end
