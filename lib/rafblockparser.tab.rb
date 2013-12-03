#
# DO NOT MODIFY!!!!
# This file is automatically generated by Racc 1.4.10
# from Racc grammer file "".
#

require 'racc/parser.rb'

require "parserutility"
require "rafinlineparser.tab"
require "rafelement"
require "erb"

module Raf

class BlockParser < Racc::Parser

module_eval(<<'...end rafblockparser.ry/module_eval...', 'rafblockparser.ry', 120)
include ParserUtility

class Line
  def initialize(line)
    @content = line
#    @indent  = get_line_indent(line)
    #    @type    = nil
  end
  attr_reader :indent, :no
  attr_accessor :type, :content
  alias indent_size indent

  def get_line_indent
    return 0 if @content.nil?
    @content =~ /(\s*)/
    $1.size
  end
  alias indent get_line_indent
end


def initialize
  @inline_parser = InlineParser.new
  @metadata = {}
  @inline_index = @inline_parser.index
  @index = {}
  @head_index = HeadIndex.new
end
attr_reader :metadata, :inline_index, :index

def parse(src)
  @no = 0
  # srcをerbで処理
  src = ERB.new(src.join).result(binding).split("\n").map {|s| "#{s}\n"}

  @src = Array(src)
  @line = Line.new("")
  @line_pre = @line.dup
  @indent_stack = []
  @current_indent = 0
  @current_type = :header
  @yydebug = true
  @view_token_type = false
  do_parse
end

def on_error(token_id, value, stack)
  lineno = @src[0..@no].to_s.split("\n").size
  raise Racc::ParseError,
        "rafblockpaser: line #{lineno}: syntax error on #{value.inspect}"
end

def next_token
  @line_pre = @line.dup
  @line = Line.new(@src[@no])
#  puts "line: #{@line.content}" if @view_token_type
  case @line.content
  when nil
      @line.content = ""
      if_current_indent_equal("") do
        puts "b: false: #{@line.content}" if @view_token_type
        [false, false]
      end
  when /^$/
    @line.content = ""
    if_current_indent_equal("") do
      if @current_type == :quote
        puts "b: QUOTE: #{@line.content}" if @view_token_type
        [:QUOTE, "\n"]
      elsif @current_type == :descline
        puts "b: DESCLINE: #{@line.content}" if @view_token_type
        [:DESCLINE, " "]
      else
        puts "b: WHITELINE: #{@line.content}" if @view_token_type
        @current_type = :whiteline
        [:WHITELINE, :WHITELINE]
      end
    end
  when /^\#(.*)/  # comment line
    @no += 1
    if @current_type == :header
      puts "b: HEADER: #{@line.content}" if @view_token_type
      [:HEADER, $1.strip]
    else
      puts "b: COMMENT(noop): #{@line.content}" if @view_token_type
      next_token
    end
  when /^(={1,4})(?!=)\s*(?=\S)/, /^(\+{1,2})(?!\+)\s*(?=\S)/
    rest = $'                    # '
    rest.strip!
    mark = $1
    #    if_current_indent_equal("") do
    if_current_indent_equal(@line.indent) do
      @current_type = :headline
      puts "b: HEADLINE: #{@line.content}" if @view_token_type
      [:HEADLINE, [mark_to_level(mark), rest]]
    end
  when /^\s\s+(.*)/    # type == quote
    puts "b: 2 WHITE SPACE(#{@current_type}) : #{@line.content}" if @view_token_type
    case @current_type
    when :itemlist
      if @line.content =~ /^(\s*)(\*)(\s+)(.*)/
        line = $4.strip
        if line.empty?
          @no += 1
          next_token
        else
          if_current_indent_equal(@line.indent) do
            puts "b: ITEMLIST: [#{line}]" if @view_token_type
            @current_type = :itemlist
            [:ITEMLIST, line]
          end
        end
      else
        line = @line.content.strip
        if line.empty?
          @no += 1
          next_token
        else
          puts "b: ITEMLISTCONTINUE: [#{line.empty?}] --" if @view_token_type
          @no += 1
          @current_type = :itemlist
          [:ITEMLISTCONTINUE, line]
        end
      end
    when :numlist
      @line.content =~ /^(\s*)(\(\d+\))(\s+)(.*)/
      if $4.nil?
        @line.content =~ /^(\s*)(\d\.)(\s+)(.*)/
      end
      line = $4
      line ||= @line.content.strip
      if line.empty?
        @no += 1
        next_token
      else
        if_current_indent_equal(@line.indent) do
          puts "b: NUMLIST: [#{line}]" if @view_token_type
          @current_type = :numlist
          [:NUMLIST, line]
        end
      end
    else
      @no += 1
      if @current_type == :descline
        @current_type = :descline
        puts "b: DESCLINE: #{@line.content}" if @view_token_type
        [:DESCLINE, $1 + "\n"]
      else
        @current_type = :quote
        puts "b: QUOTE: #{$1}" if @view_token_type
        [:QUOTE, @line.content.sub("  ","")]
      end
    end
  when /^(\:)(.*)/ # type = desclist
   if_current_indent_equal(@line.indent) do
      @current_type = :descline
      puts "b: DESCLINE_TILTE: #{$2.strip}" if @view_token_type
      [:DESCLINE_TITLE, $2.strip]
    end
  when /^(\s*)(\*)(\s+)(.*)/ # type = itemlist
    if_current_indent_equal(@line.indent) do
        puts "b: ITEMLIST: #{@line.content}" if @view_token_type
        @current_type = :itemlist
        [:ITEMLIST, $4]
    end
  when /^(\s*)(\(\d+\))(\s+)(.*)/
    if_current_indent_equal(@line.indent) do
        puts "b: NUMLIST: #{@line.content}" if @view_token_type
        @current_type = :numlist
        [:NUMLIST, $4]
    end
  when  /^(\s*)(\d+\.)(\s+)(.*)/ # type = numlist
    if_current_indent_equal(@line.indent) do
        puts "b: NUMLIST: #{@line.content}" if @view_token_type
        @current_type = :numlist
        [:NUMLIST, $4]
    end
  when /^\|.*/ # type = table
    @no += 1
    @current_type = :table
    lines = @line.content.chomp.split("|")
    lines.shift
    [:TABLELINE, lines]
  when /(.*)/    # type == plain
    @current_type = :plain
    if_current_indent_equal(@line.indent) do
      puts "b: PLAIN: #{@line.content}" if @view_token_type
      [:PLAIN, @line.content]
    end
  else
    puts "raise : #{@line}"
  end
end

def if_current_indent_equal(ident)
  indent_space = 2
  puts "current: #{@current_indent}, line: #{@line.indent}, stack #{@indent_stack.size}:" if @view_token_type
  indent_sabun = @current_indent - @line.indent
  if indent_sabun >= -1 and indent_sabun <= 1
    @no += 1
    yield
  elsif @current_indent < @line.indent
    ((@line.indent - @current_indent) / indent_space).times do
      @indent_stack.push("")
    end
    @current_indent = @line.indent
    puts "b: INDENT" if @view_token_type
    [:INDENT, :INDENT]
  else
    @indent_stack.pop
    @current_indent = @line.indent if @line.indent == @indent_stack.size * indent_space
    puts "b: DEDENT" if @view_token_type
    [:DEDENT, :DEDENT]
  end
end

...end rafblockparser.ry/module_eval...
##### State transition tables begin ###

racc_action_table = [
    13,    12,    14,    16,    17,    46,    19,    23,    35,    25,
    25,    29,    31,    13,    12,    14,    16,    17,    25,    19,
    23,    47,    25,    37,    29,    31,    23,    29,    25,    37,
    29,    37,    52,    29,    48,    29,    35,    51,    25,    35,
    49,    25,    41,    40,    50,    38,    32,    53 ]

racc_action_check = [
     0,     0,     0,     0,     0,    25,     0,     0,    35,     0,
    35,     0,     0,     2,     2,     2,     2,     2,    21,     2,
     2,    27,     2,     8,     2,     2,    23,     8,    23,    37,
    23,    44,    44,    37,    30,    44,    43,    43,    43,     7,
    32,     7,    18,    17,    39,    15,     1,    45 ]

racc_action_pointer = [
    -2,    46,    11,   nil,   nil,   nil,   nil,    30,    14,   nil,
   nil,   nil,   nil,   nil,   nil,    40,   nil,    36,    34,   nil,
   nil,     7,   nil,    17,   nil,    -7,   nil,     8,   nil,   nil,
    20,   nil,    40,   nil,   nil,    -1,   nil,    20,   nil,    37,
   nil,   nil,   nil,    27,    22,    35,   nil,   nil,   nil,   nil,
   nil,   nil,   nil,   nil ]

racc_action_default = [
   -46,   -46,    -1,    -2,    -4,    -5,    -6,    -7,    -8,    -9,
   -10,   -11,   -12,   -13,   -14,   -15,   -16,   -21,   -22,   -23,
   -25,   -27,   -28,   -46,   -30,   -32,   -36,   -38,   -39,   -41,
   -43,   -44,   -46,    -3,   -26,   -46,   -37,   -46,   -17,   -18,
   -19,   -24,   -31,   -46,   -46,   -33,   -34,   -42,   -45,    54,
   -20,   -29,   -40,   -35 ]

racc_goto_table = [
    36,    34,    44,    43,     3,    39,    33,     2,    42,    45,
     1,   nil,   nil,   nil,   nil,    43,    44,   nil,   nil,   nil,
   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,
   nil,   nil,   nil,   nil,   nil,   nil,    36,    34 ]

racc_goto_check = [
    20,    15,     8,     7,     3,    13,     3,     2,    18,    19,
     1,   nil,   nil,   nil,   nil,     7,     8,   nil,   nil,   nil,
   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,
   nil,   nil,   nil,   nil,   nil,   nil,    20,    15 ]

racc_goto_pointer = [
   nil,    10,     7,     4,   nil,   nil,   nil,   -20,   -21,   nil,
   nil,   nil,   nil,   -12,   nil,    -6,   nil,   nil,   -13,   -16,
    -8,   nil,   nil,   nil ]

racc_goto_default = [
   nil,   nil,   nil,   nil,     4,     5,     6,     7,     8,     9,
    10,    11,    15,   nil,    18,    20,    21,    22,    24,   nil,
    26,    27,    28,    30 ]

racc_reduce_table = [
  0, 0, :racc_error,
  1, 17, :_reduce_1,
  1, 18, :_reduce_2,
  2, 18, :_reduce_3,
  1, 19, :_reduce_none,
  1, 19, :_reduce_5,
  1, 19, :_reduce_none,
  1, 19, :_reduce_7,
  1, 19, :_reduce_8,
  1, 19, :_reduce_none,
  1, 19, :_reduce_none,
  1, 19, :_reduce_none,
  1, 19, :_reduce_12,
  1, 20, :_reduce_13,
  1, 27, :_reduce_14,
  1, 21, :_reduce_15,
  1, 28, :_reduce_16,
  2, 28, :_reduce_17,
  2, 25, :_reduce_18,
  1, 29, :_reduce_19,
  2, 29, :_reduce_20,
  0, 29, :_reduce_none,
  1, 22, :_reduce_22,
  1, 30, :_reduce_23,
  2, 30, :_reduce_24,
  1, 23, :_reduce_25,
  2, 23, :_reduce_26,
  1, 31, :_reduce_27,
  1, 31, :_reduce_28,
  3, 33, :_reduce_29,
  1, 32, :_reduce_30,
  2, 32, :_reduce_31,
  1, 34, :_reduce_32,
  2, 34, :_reduce_33,
  1, 35, :_reduce_34,
  2, 35, :_reduce_35,
  1, 24, :_reduce_36,
  2, 24, :_reduce_37,
  1, 36, :_reduce_38,
  1, 36, :_reduce_39,
  3, 38, :_reduce_40,
  1, 37, :_reduce_41,
  2, 37, :_reduce_42,
  1, 26, :_reduce_43,
  1, 39, :_reduce_44,
  2, 39, :_reduce_45 ]

racc_reduce_n = 46

racc_shift_n = 54

racc_token_table = {
  false => 0,
  :error => 1,
  :HEADER => 2,
  :WHITELINE => 3,
  :HEADLINE => 4,
  :PLAIN => 5,
  :DESCLINE_TITLE => 6,
  :DESCLINE => 7,
  :QUOTE => 8,
  :INDENT => 9,
  :DEDENT => 10,
  :ITEMLIST => 11,
  :ITEMLISTCONTINUE => 12,
  :NUMLIST => 13,
  :TABLELINE => 14,
  :DUMMY => 15 }

racc_nt_base = 16

racc_use_result_var = false

Racc_arg = [
  racc_action_table,
  racc_action_check,
  racc_action_default,
  racc_action_pointer,
  racc_goto_table,
  racc_goto_check,
  racc_goto_default,
  racc_goto_pointer,
  racc_nt_base,
  racc_reduce_table,
  racc_token_table,
  racc_shift_n,
  racc_reduce_n,
  racc_use_result_var ]

Racc_token_to_s_table = [
  "$end",
  "error",
  "HEADER",
  "WHITELINE",
  "HEADLINE",
  "PLAIN",
  "DESCLINE_TITLE",
  "DESCLINE",
  "QUOTE",
  "INDENT",
  "DEDENT",
  "ITEMLIST",
  "ITEMLISTCONTINUE",
  "NUMLIST",
  "TABLELINE",
  "DUMMY",
  "$start",
  "document",
  "blocks",
  "block",
  "header",
  "paragraph",
  "quote_block",
  "itemlist_blocks",
  "numlist_blocks",
  "desc_block",
  "table_block",
  "headline",
  "plain_texts",
  "desclines",
  "quotes",
  "itemlist_block",
  "itemlists",
  "itemlist_indent_blocks",
  "itemlistitems",
  "itemlist_continues",
  "numlist_block",
  "numlists",
  "numlist_indent_blocks",
  "tablelines" ]

Racc_debug_parser = false

##### State transition tables end #####

# reduce 0 omitted

module_eval(<<'.,.,', 'rafblockparser.ry', 10)
  def _reduce_1(val, _values)
     val[0].compact 
  end
.,.,

module_eval(<<'.,.,', 'rafblockparser.ry', 12)
  def _reduce_2(val, _values)
     val 
  end
.,.,

module_eval(<<'.,.,', 'rafblockparser.ry', 13)
  def _reduce_3(val, _values)
     [val[0], val[1]].flatten 
  end
.,.,

# reduce 4 omitted

module_eval(<<'.,.,', 'rafblockparser.ry', 16)
  def _reduce_5(val, _values)
     val[0] 
  end
.,.,

# reduce 6 omitted

module_eval(<<'.,.,', 'rafblockparser.ry', 18)
  def _reduce_7(val, _values)
     ItemList.new(val[0].flatten) 
  end
.,.,

module_eval(<<'.,.,', 'rafblockparser.ry', 19)
  def _reduce_8(val, _values)
     NumList.new(val[0].flatten) 
  end
.,.,

# reduce 9 omitted

# reduce 10 omitted

# reduce 11 omitted

module_eval(<<'.,.,', 'rafblockparser.ry', 23)
  def _reduce_12(val, _values)
     WhiteLine.new 
  end
.,.,

module_eval(<<'.,.,', 'rafblockparser.ry', 27)
  def _reduce_13(val, _values)
                 name, val = val[0].split(":",2)
             if name.nil? or val.nil?
             else
               @metadata.update({name.strip.to_sym => val.strip })
             end
             nil 
  end
.,.,

module_eval(<<'.,.,', 'rafblockparser.ry', 35)
  def _reduce_14(val, _values)
     # val[0] is like [level, title, index]
                        title = val[0][1]
                        level = val[0][0]
                        if level == 1
                          @metadata[:subject] ||= title
                        else
                          @head_index.update(level)
                        end

                        @index[:head] ||= []
                        @index[:head] << {:title => title, :level => level, :index => @head_index.to_s}
                        HeadLine.new([level, title, @index[:head].size, @head_index.to_s]) 
  end
.,.,

module_eval(<<'.,.,', 'rafblockparser.ry', 48)
  def _reduce_15(val, _values)
     Paragraph.new @inline_parser.parse(val) 
  end
.,.,

module_eval(<<'.,.,', 'rafblockparser.ry', 50)
  def _reduce_16(val, _values)
     val[0] 
  end
.,.,

module_eval(<<'.,.,', 'rafblockparser.ry', 51)
  def _reduce_17(val, _values)
     val[0] + val[1] 
  end
.,.,

module_eval(<<'.,.,', 'rafblockparser.ry', 55)
  def _reduce_18(val, _values)
                     if val[1].nil?
                   lines = [Plain.new("")]
                 else
                   lines = @inline_parser.parse(val[1])
                 end
                 Desc.new([val[0], lines])
               
  end
.,.,

module_eval(<<'.,.,', 'rafblockparser.ry', 64)
  def _reduce_19(val, _values)
     val[0] 
  end
.,.,

module_eval(<<'.,.,', 'rafblockparser.ry', 65)
  def _reduce_20(val, _values)
     val[0] + val[1] 
  end
.,.,

# reduce 21 omitted

module_eval(<<'.,.,', 'rafblockparser.ry', 70)
  def _reduce_22(val, _values)
     qu = val[0].strip  ; Quote.new([qu]) unless qu.empty? 
  end
.,.,

module_eval(<<'.,.,', 'rafblockparser.ry', 72)
  def _reduce_23(val, _values)
     val[0] 
  end
.,.,

module_eval(<<'.,.,', 'rafblockparser.ry', 73)
  def _reduce_24(val, _values)
     val[0] + val[1] 
  end
.,.,

module_eval(<<'.,.,', 'rafblockparser.ry', 77)
  def _reduce_25(val, _values)
     val[0] 
  end
.,.,

module_eval(<<'.,.,', 'rafblockparser.ry', 78)
  def _reduce_26(val, _values)
     val[0] << val[1] 
  end
.,.,

module_eval(<<'.,.,', 'rafblockparser.ry', 80)
  def _reduce_27(val, _values)
     val[0] 
  end
.,.,

module_eval(<<'.,.,', 'rafblockparser.ry', 81)
  def _reduce_28(val, _values)
     val[0]  
  end
.,.,

module_eval(<<'.,.,', 'rafblockparser.ry', 83)
  def _reduce_29(val, _values)
     val 
  end
.,.,

module_eval(<<'.,.,', 'rafblockparser.ry', 85)
  def _reduce_30(val, _values)
    [PlainTextBlock.new(@inline_parser.parse(val[0]))]
  end
.,.,

module_eval(<<'.,.,', 'rafblockparser.ry', 86)
  def _reduce_31(val, _values)
     val[0] << PlainTextBlock.new(@inline_parser.parse(val[1])) 
  end
.,.,

module_eval(<<'.,.,', 'rafblockparser.ry', 88)
  def _reduce_32(val, _values)
     val[0] 
  end
.,.,

module_eval(<<'.,.,', 'rafblockparser.ry', 89)
  def _reduce_33(val, _values)
     val[0] + val[1] 
  end
.,.,

module_eval(<<'.,.,', 'rafblockparser.ry', 91)
  def _reduce_34(val, _values)
     "\n" + val[0]  
  end
.,.,

module_eval(<<'.,.,', 'rafblockparser.ry', 92)
  def _reduce_35(val, _values)
     val[0] + "\n" + val[1] 
  end
.,.,

module_eval(<<'.,.,', 'rafblockparser.ry', 96)
  def _reduce_36(val, _values)
     val[0] 
  end
.,.,

module_eval(<<'.,.,', 'rafblockparser.ry', 97)
  def _reduce_37(val, _values)
     val[0] << val[1] 
  end
.,.,

module_eval(<<'.,.,', 'rafblockparser.ry', 99)
  def _reduce_38(val, _values)
     val[0] 
  end
.,.,

module_eval(<<'.,.,', 'rafblockparser.ry', 100)
  def _reduce_39(val, _values)
     val[0]  
  end
.,.,

module_eval(<<'.,.,', 'rafblockparser.ry', 102)
  def _reduce_40(val, _values)
     val 
  end
.,.,

module_eval(<<'.,.,', 'rafblockparser.ry', 104)
  def _reduce_41(val, _values)
     [PlainTextBlock.new(@inline_parser.parse(val[0]))] 
  end
.,.,

module_eval(<<'.,.,', 'rafblockparser.ry', 105)
  def _reduce_42(val, _values)
     val[0] << PlainTextBlock.new(@inline_parser.parse(val[1])) 
  end
.,.,

module_eval(<<'.,.,', 'rafblockparser.ry', 110)
  def _reduce_43(val, _values)
     Table.new(val[0]) 
  end
.,.,

module_eval(<<'.,.,', 'rafblockparser.ry', 112)
  def _reduce_44(val, _values)
      val 
  end
.,.,

module_eval(<<'.,.,', 'rafblockparser.ry', 113)
  def _reduce_45(val, _values)
     val[0] << val[1] 
  end
.,.,

def _reduce_none(val, _values)
  val[0]
end

end   # class BlockParser

  if __FILE__ == $0
    raf = BlockParser.new
    src = $stdin.readlines
    nodes = raf.parse(src)
    puts "----- index -----"
    raf.index.each do |key,val|
      puts key
      val.each do |v| p v end
    end
    puts "----- info -----"
    p raf.info
    puts "----- output -----"
    nodes.each do |n|
      puts n.apply
    end
  end
end # end of module Raf
