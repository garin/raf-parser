#
# DO NOT MODIFY!!!!
# This file is automatically generated by Racc 1.4.10
# from Racc grammer file "".
#

require 'racc/parser.rb'

require "parserutility"
require 'strscan'
require 'erb'
require 'rafelement'

module Raf
class InlineParser < Racc::Parser

module_eval(<<'...end rafinlineparser.ry/module_eval...', 'rafinlineparser.ry', 178)
include ParserUtility

EM_OPEN = '((*'
EM_OPEN_RE = /\A#{Regexp.quote(EM_OPEN)}/
EM_CLOSE = '*))'
EM_CLOSE_RE = /\A#{Regexp.quote(EM_CLOSE)}/

ITALIC_OPEN = '((_'
ITALIC_OPEN_RE = /\A#{Regexp.quote(ITALIC_OPEN)}/
ITALIC_CLOSE = '_))'
ITALIC_CLOSE_RE = /\A#{Regexp.quote(ITALIC_CLOSE)}/

STRIKE_OPEN = '((-'
STRIKE_OPEN_RE = /\A#{Regexp.quote(STRIKE_OPEN)}/
STRIKE_CLOSE = '-))'
STRIKE_CLOSE_RE = /\A#{Regexp.quote(STRIKE_CLOSE)}/

RUBY_OPEN = '((^'
RUBY_OPEN_RE = /\A#{Regexp.quote(RUBY_OPEN)}/
RUBY_CLOSE = '^))'
RUBY_CLOSE_RE = /\A#{Regexp.quote(RUBY_CLOSE)}/

FOOTNOTE_OPEN = '((['
FOOTNOTE_OPEN_RE = /\A#{Regexp.quote(FOOTNOTE_OPEN)}/
FOOTNOTE_CLOSE = ']))'
FOOTNOTE_CLOSE_RE = /\A#{Regexp.quote(FOOTNOTE_CLOSE)}/

IMAGE_OPEN = '(($'
IMAGE_OPEN_RE = /\A#{Regexp.quote(IMAGE_OPEN)}/
IMAGE_CLOSE = '$))'
IMAGE_CLOSE_RE = /\A#{Regexp.quote(IMAGE_CLOSE)}/

LABEL_OPEN = '((>'
LABEL_OPEN_RE = /\A#{Regexp.quote(LABEL_OPEN)}/
LABEL_CLOSE = '<))'
LABEL_CLOSE_RE = /\A#{Regexp.quote(LABEL_CLOSE)}/

LABEL_HTML_OPEN = '((&gt;'
LABEL_HTML_OPEN_RE = /\A#{Regexp.quote(LABEL_HTML_OPEN)}/
LABEL_HTML_CLOSE = '&lt;))'
LABEL_HTML_CLOSE_RE = /\A#{Regexp.quote(LABEL_HTML_CLOSE)}/

REFERENCE_OPEN = '((<'
REFERENCE_OPEN_RE = /\A#{Regexp.quote(REFERENCE_OPEN)}/
REFERENCE_CLOSE = '>))'
REFERENCE_CLOSE_RE = /\A#{Regexp.quote(REFERENCE_CLOSE)}/

REFERENCE_HTML_OPEN = '((<'
REFERENCE_HTML_OPEN_RE = /\A#{Regexp.quote(REFERENCE_HTML_OPEN)}/
REFERENCE_HTML_CLOSE = '>))'
REFERENCE_HTML_CLOSE_RE = /\A#{Regexp.quote(REFERENCE_HTML_CLOSE)}/

VERB_OPEN = "(('"
VERB_OPEN_RE = /\A#{Regexp.quote(VERB_OPEN)}/
VERB_CLOSE = "'))"
VERB_CLOSE_RE = /\A#{Regexp.quote(VERB_CLOSE)}/

MANUEDO_OPEN = "((/"
MANUEDO_OPEN_RE = /\A#{Regexp.quote(MANUEDO_OPEN)}/
MANUEDO_CLOSE = "/))"
MANUEDO_CLOSE_RE = /\A#{Regexp.quote(MANUEDO_CLOSE)}/

ERB_OPEN = "<%="
ERB_OPEN_RE = /\A#{Regexp.quote(ERB_OPEN)}/
ERB_CLOSE = "%>"
ERB_CLOSE_RE = /\A#{Regexp.quote(ERB_CLOSE)}/

# URL = "URL:"
# URL_RE = /\A#{Regexp.quote(URL)}/

#other_re_mode = Regexp::EXTENDED
other_re_mode = Regexp::MULTILINE
OTHER_RE = Regexp.new(
                      "\\A.+?(?=#{Regexp.quote(EM_OPEN)}|#{Regexp.quote(EM_CLOSE)}|#{Regexp.quote(ITALIC_OPEN)}|#{Regexp.quote(ITALIC_CLOSE)}|#{Regexp.quote(STRIKE_OPEN)}|#{Regexp.quote(STRIKE_CLOSE)}|#{Regexp.quote(FOOTNOTE_OPEN)}|#{Regexp.quote(FOOTNOTE_CLOSE)}|#{Regexp.quote(RUBY_OPEN)}|#{Regexp.quote(RUBY_CLOSE)}|#{Regexp.quote(IMAGE_OPEN)}|#{Regexp.quote(IMAGE_CLOSE)}|#{Regexp.quote(LABEL_OPEN)}|#{Regexp.quote(LABEL_CLOSE)}|#{Regexp.quote(LABEL_HTML_OPEN)}|#{Regexp.quote(LABEL_HTML_CLOSE)}|#{Regexp.quote(REFERENCE_OPEN)}|#{Regexp.quote(REFERENCE_CLOSE)}|#{Regexp.quote(REFERENCE_HTML_OPEN)}|#{Regexp.quote(REFERENCE_HTML_CLOSE)}|#{Regexp.quote(MANUEDO_OPEN)}|#{Regexp.quote(MANUEDO_CLOSE)}|#{Regexp.quote(VERB_OPEN)}|#{Regexp.quote(VERB_CLOSE)}|#{Regexp.quote(ERB_OPEN)}|#{Regexp.quote(ERB_CLOSE)})", other_re_mode)

def parse(src)
  @src = StringScanner.new(Array(src).join)
  @pre = ""
  @@yydebug = false
  @view_token_type = false
  do_parse
end
def initialize
  @index = {}
end
attr_reader :index

def next_token
  return [false, false] if @src.eos?
  if ret = @src.scan(EM_OPEN_RE)
    puts "i: EM_OPEN: #{ret}" if @view_token_type
    @pre << ret
    [:EM_OPEN, ret]
  elsif ret = @src.scan(EM_CLOSE_RE)
    puts "i: EM_CLOSE: #{ret}" if @view_token_type
    @pre << ret
    [:EM_CLOSE, ret]
  elsif ret = @src.scan(ITALIC_OPEN_RE)
    puts "i: ITALIC_OPEN: #{ret}" if @view_token_type
    @pre << ret
    [:ITALIC_OPEN, ret]
  elsif ret = @src.scan(ITALIC_CLOSE_RE)
    puts "i: ITALIC_CLOSE: #{ret}" if @view_token_type
    @pre << ret
    [:ITALIC_CLOSE, ret]
  elsif ret = @src.scan(STRIKE_OPEN_RE)
    @pre << ret
    puts "i: STRIKE_OPEN: #{ret}" if @view_token_type
    [:STRIKE_OPEN, ret]
  elsif ret = @src.scan(STRIKE_CLOSE_RE)
    @pre << ret
    puts "i: STRIKE_CLOSE: #{ret}" if @view_token_type
    [:STRIKE_CLOSE, ret]
  elsif ret = @src.scan(LABEL_OPEN_RE)
    @pre << ret
    puts "i: LABEL_OPEN: #{ret}" if @view_token_type
    [:LABEL_OPEN, ret]
  elsif ret = @src.scan(LABEL_CLOSE_RE)
    puts "i: LABEL_CLOSE: #{ret}" if @view_token_type
    @pre << ret
    [:LABEL_CLOSE, ret]
  elsif ret = @src.scan(LABEL_HTML_OPEN_RE)
    @pre << ret
    puts "i: LABEL_OPEN: #{ret}" if @view_token_type
    [:LABEL_OPEN, ret]
  elsif ret = @src.scan(LABEL_HTML_CLOSE_RE)
    puts "i: LABEL_CLOSE: #{ret}" if @view_token_type
    @pre << ret
    [:LABEL_CLOSE, ret]
  elsif ret = @src.scan(REFERENCE_OPEN_RE)
    puts "i: REFERENCE_OPEN: #{ret}" if @view_token_type
    @pre << ret
    [:REFERENCE_OPEN, ret]
  elsif ret = @src.scan(REFERENCE_CLOSE_RE)
    puts "i: REFERENCE_CLOSE: #{ret}" if @view_token_type
    @pre << ret
    [:REFERENCE_CLOSE, ret]
  elsif ret = @src.scan(REFERENCE_HTML_OPEN_RE)
    puts "i: REFERENCE_HTML_OPEN: #{ret}" if @view_token_type
    @pre << ret
    [:REFERENCE_OPEN, ret]
  elsif ret = @src.scan(REFERENCE_HTML_CLOSE_RE)
    puts "i: REFERENCE_HTML_CLOSE: #{ret}" if @view_token_type
    @pre << ret
    [:REFERENCE_CLOSE, ret]
  elsif ret = @src.scan(VERB_OPEN_RE)
    puts "i: VERB_OPEN: #{ret}" if @view_token_type
    @pre << ret
    [:VERB_OPEN, ret]
  elsif ret = @src.scan(VERB_CLOSE_RE)
    puts "i: VERB_CLOSE: #{ret}" if @view_token_type
    @pre << ret
    [:VERB_CLOSE, ret]
  elsif ret = @src.scan(RUBY_OPEN_RE)
    puts "i: RUBY_OPEN: #{ret}" if @view_token_type
    @pre << ret
    [:RUBY_OPEN, ret]
  elsif ret = @src.scan(RUBY_CLOSE_RE)
    puts "i: RUBY_CLOSE: #{ret}" if @view_token_type
    @pre << ret
    [:RUBY_CLOSE, ret]
  elsif ret = @src.scan(FOOTNOTE_OPEN_RE)
    puts "i: FOOTNOTE_OPEN: #{ret}" if @view_token_type
    @pre << ret
    [:FOOTNOTE_OPEN, ret]
  elsif ret = @src.scan(FOOTNOTE_CLOSE_RE)
    puts "i: FOOTNOTE_CLOSE: #{ret}" if @view_token_type
    @pre << ret
    [:FOOTNOTE_CLOSE, ret]
  elsif ret = @src.scan(IMAGE_OPEN_RE)
    puts "i: IMAGE_OPEN: #{ret}" if @view_token_type
    @pre << ret
    [:IMAGE_OPEN, ret]
  elsif ret = @src.scan(IMAGE_CLOSE_RE)
    puts "i: IMAGE_CLOSE: #{ret}" if @view_token_type
    @pre << ret
    [:IMAGE_CLOSE, ret]
  elsif ret = @src.scan(MANUEDO_OPEN_RE)
    puts "i: MANUEDO_OPEN: #{ret}" if @view_token_type
    @pre << ret
    [:MANUEDO_OPEN, ret]
  elsif ret = @src.scan(MANUEDO_CLOSE_RE)
    puts "i: MANUED_CLOSE: #{ret}" if @view_token_type
    @pre << ret
    [:MANUEDO_CLOSE, ret]
  elsif ret = @src.scan(ERB_OPEN_RE)
    puts "i: ERB_OPEN: #{ret}" if @view_token_type
    @pre << ret
    [:ERB_OPEN, ret]
  elsif ret = @src.scan(ERB_CLOSE_RE)
    puts "i: ERB_CLOSE: #{ret}" if @view_token_type
    @pre << ret
    [:ERB_CLOSE, ret]
  elsif ret = @src.scan(OTHER_RE)
    puts "i: OTHER_RE: #{ret}" if @view_token_type
    @pre << ret
    [:OTHER, ret]
  else
    puts "i: OTHER_RE(else): #{ret}" if @view_token_type
    ret = @src.rest
    @pre << ret
    @src.terminate
    [:OTHER, ret]
  end
end

...end rafinlineparser.ry/module_eval...
##### State transition tables begin ###

racc_action_table = [
    16,    28,    17,   118,    18,   119,    24,   120,    25,   117,
    26,    29,    22,   125,    19,   126,    21,   108,    20,   116,
    23,   111,    28,    61,    62,    63,    64,    65,    66,    75,
    76,    73,    74,    80,    81,    71,    72,    78,    79,    77,
   124,    67,    68,    69,    70,    60,    16,   nil,    17,   nil,
    18,   nil,    24,   nil,    25,   nil,    26,   nil,    22,   nil,
    19,   nil,    21,   nil,    20,   nil,    23,   nil,    28,    37,
    38,    39,    40,    41,    42,    51,    52,    49,    50,    55,
    56,    47,    48,    53,    54,    43,    44,    57,   122,    45,
    46,    36,    16,    16,    17,    17,    18,    18,    24,    24,
    25,    25,    26,    26,    22,    22,    19,    19,    21,    21,
    20,    20,    23,    23,    28,    28,    16,    16,    17,    17,
    18,    18,    24,    24,    25,    25,    26,    26,    22,    22,
    19,    19,    21,    21,    20,    20,    23,    23,    28,    28,
    37,    38,    39,    40,    41,    42,    51,    52,    49,    50,
    55,    56,    47,    48,    53,    54,    43,    44,    57,   nil,
    45,    46,    36,    61,    62,    63,    64,    65,    66,    75,
    76,    73,    74,    80,    81,    71,    72,    78,    79,    77,
   nil,    67,    68,    69,    70,    60,    86,    87,    88,    89,
    90,    91,   100,   101,    98,    99,   106,   128,    96,    97,
   104,   105,   102,   103,    92,    93,    94,    95,    85,    16,
   nil,    17,   108,    18,   nil,    24,   nil,    25,   nil,    26,
   nil,    22,   nil,    19,   nil,    21,   nil,    20,   nil,    23,
   130,    28,    86,    87,    88,    89,    90,    91,   100,   101,
    98,    99,   106,   111,    96,    97,   104,   105,   102,   103,
    92,    93,    94,    95,    85,    86,    87,    88,    89,    90,
    91,   100,   101,    98,    99,   106,   132,    96,    97,   104,
   105,   102,   103,    92,    93,    94,    95,    85 ]

racc_action_check = [
     0,    15,     0,    33,     0,    34,     0,    35,     0,    32,
     0,     1,     0,    84,     0,   107,     0,    24,     0,    29,
     0,    25,     0,    82,    82,    82,    82,    82,    82,    82,
    82,    82,    82,    82,    82,    82,    82,    82,    82,    82,
    82,    82,    82,    82,    82,    82,     2,   nil,     2,   nil,
     2,   nil,     2,   nil,     2,   nil,     2,   nil,     2,   nil,
     2,   nil,     2,   nil,     2,   nil,     2,   nil,     2,    58,
    58,    58,    58,    58,    58,    58,    58,    58,    58,    58,
    58,    58,    58,    58,    58,    58,    58,    58,    58,    58,
    58,    58,    16,    17,    16,    17,    16,    17,    16,    17,
    16,    17,    16,    17,    16,    17,    16,    17,    16,    17,
    16,    17,    16,    17,    16,    17,    18,    19,    18,    19,
    18,    19,    18,    19,    18,    19,    18,    19,    18,    19,
    18,    19,    18,    19,    18,    19,    18,    19,    18,    19,
    20,    20,    20,    20,    20,    20,    20,    20,    20,    20,
    20,    20,    20,    20,    20,    20,    20,    20,    20,   nil,
    20,    20,    20,    21,    21,    21,    21,    21,    21,    21,
    21,    21,    21,    21,    21,    21,    21,    21,    21,    21,
   nil,    21,    21,    21,    21,    21,    22,    22,    22,    22,
    22,    22,    22,    22,    22,    22,    22,   109,    22,    22,
    22,    22,    22,    22,    22,    22,    22,    22,    22,    23,
   nil,    23,   109,    23,   nil,    23,   nil,    23,   nil,    23,
   nil,    23,   nil,    23,   nil,    23,   nil,    23,   nil,    23,
   112,    23,    26,    26,    26,    26,    26,    26,    26,    26,
    26,    26,    26,   112,    26,    26,    26,    26,    26,    26,
    26,    26,    26,    26,    26,   115,   115,   115,   115,   115,
   115,   115,   115,   115,   115,   115,   115,   115,   115,   115,
   115,   115,   115,   115,   115,   115,   115,   115 ]

racc_action_pointer = [
    -2,    11,    44,   nil,   nil,   nil,   nil,   nil,   nil,   nil,
   nil,   nil,   nil,   nil,   nil,   -23,    90,    91,   114,   115,
   138,   161,   184,   207,    -7,    -3,   230,   nil,   nil,    19,
   nil,   nil,     6,    -2,    -2,   -10,   nil,   nil,   nil,   nil,
   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,
   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,    67,   nil,
   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,
   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,
   nil,   nil,    21,   nil,    -2,   nil,   nil,   nil,   nil,   nil,
   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,
   nil,   nil,   nil,   nil,   nil,   nil,   nil,    -8,   nil,   188,
   nil,   nil,   219,   nil,   nil,   253,   nil,   nil,   nil,   nil,
   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,
   nil,   nil,   nil ]

racc_action_default = [
    -1,  -109,    -2,    -4,    -5,    -6,    -7,    -8,    -9,   -10,
   -11,   -12,   -13,   -14,   -15,   -16,    -1,    -1,    -1,    -1,
  -109,  -109,  -109,    -1,  -109,  -109,  -109,  -106,  -108,  -109,
    -3,  -107,  -109,  -109,  -109,  -109,   -21,   -22,   -23,   -24,
   -25,   -26,   -27,   -28,   -29,   -30,   -31,   -32,   -33,   -34,
   -35,   -36,   -37,   -38,   -39,   -40,   -41,   -42,  -109,   -44,
   -46,   -47,   -48,   -49,   -50,   -51,   -52,   -53,   -54,   -55,
   -56,   -57,   -58,   -59,   -60,   -61,   -62,   -63,   -64,   -65,
   -66,   -67,  -109,   -69,  -109,   -81,   -82,   -83,   -84,   -85,
   -86,   -87,   -88,   -89,   -90,   -91,   -92,   -93,   -94,   -95,
   -96,   -97,   -98,   -99,  -100,  -101,  -102,  -109,   -73,  -109,
   -75,   -77,  -109,   -79,  -103,  -109,   133,   -17,   -18,   -19,
   -20,   -43,   -45,   -68,   -70,   -71,   -72,   -74,   -76,   -78,
   -80,  -104,  -105 ]

racc_goto_table = [
    84,   113,   110,    83,   114,    59,     1,    82,    58,   109,
    30,   112,   115,    31,   nil,   nil,   nil,   nil,   nil,   nil,
   nil,   nil,    32,    33,    34,    35,   nil,   nil,   nil,   107,
   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,
   nil,   nil,   nil,   121,   nil,   nil,   nil,   nil,   nil,   nil,
   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,
   nil,   nil,   nil,   nil,   123,   nil,   nil,   nil,   nil,   nil,
   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,
   nil,   nil,   nil,   nil,   nil,   nil,   nil,   127,   129,   nil,
   nil,   nil,   nil,   131 ]

racc_goto_check = [
    20,    23,    21,    18,    20,    16,     1,    19,    17,    22,
     3,    24,    25,    26,   nil,   nil,   nil,   nil,   nil,   nil,
   nil,   nil,     1,     1,     1,     1,   nil,   nil,   nil,     1,
   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,
   nil,   nil,   nil,    16,   nil,   nil,   nil,   nil,   nil,   nil,
   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,
   nil,   nil,   nil,   nil,    18,   nil,   nil,   nil,   nil,   nil,
   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,
   nil,   nil,   nil,   nil,   nil,   nil,   nil,    21,    23,   nil,
   nil,   nil,   nil,    20 ]

racc_goto_pointer = [
   nil,     6,   nil,     8,   nil,   nil,   nil,   nil,   nil,   nil,
   nil,   nil,   nil,   nil,   nil,   nil,   -15,   -12,   -18,   -14,
   -22,   -22,   -15,   -24,   -14,   -14,    -2 ]

racc_goto_default = [
   nil,   nil,     2,     3,     4,     5,     6,     7,     8,     9,
    10,    11,    12,    13,    14,    15,   nil,   nil,   nil,   nil,
   nil,   nil,   nil,   nil,   nil,   nil,    27 ]

racc_reduce_table = [
  0, 0, :racc_error,
  0, 26, :_reduce_none,
  1, 26, :_reduce_none,
  2, 27, :_reduce_3,
  1, 27, :_reduce_4,
  1, 28, :_reduce_none,
  1, 28, :_reduce_none,
  1, 28, :_reduce_none,
  1, 28, :_reduce_none,
  1, 28, :_reduce_none,
  1, 28, :_reduce_none,
  1, 28, :_reduce_none,
  1, 28, :_reduce_none,
  1, 28, :_reduce_none,
  1, 28, :_reduce_none,
  1, 28, :_reduce_none,
  1, 28, :_reduce_none,
  3, 29, :_reduce_17,
  3, 30, :_reduce_18,
  3, 31, :_reduce_19,
  3, 35, :_reduce_20,
  1, 41, :_reduce_none,
  1, 41, :_reduce_none,
  1, 41, :_reduce_none,
  1, 41, :_reduce_none,
  1, 41, :_reduce_none,
  1, 41, :_reduce_none,
  1, 41, :_reduce_none,
  1, 41, :_reduce_none,
  1, 41, :_reduce_none,
  1, 41, :_reduce_none,
  1, 41, :_reduce_none,
  1, 41, :_reduce_none,
  1, 41, :_reduce_none,
  1, 41, :_reduce_none,
  1, 41, :_reduce_none,
  1, 41, :_reduce_none,
  1, 41, :_reduce_none,
  1, 41, :_reduce_none,
  1, 41, :_reduce_none,
  1, 41, :_reduce_none,
  1, 41, :_reduce_none,
  1, 41, :_reduce_none,
  2, 42, :_reduce_43,
  1, 42, :_reduce_44,
  3, 36, :_reduce_45,
  1, 43, :_reduce_none,
  1, 43, :_reduce_none,
  1, 43, :_reduce_none,
  1, 43, :_reduce_none,
  1, 43, :_reduce_none,
  1, 43, :_reduce_none,
  1, 43, :_reduce_none,
  1, 43, :_reduce_none,
  1, 43, :_reduce_none,
  1, 43, :_reduce_none,
  1, 43, :_reduce_none,
  1, 43, :_reduce_none,
  1, 43, :_reduce_none,
  1, 43, :_reduce_none,
  1, 43, :_reduce_none,
  1, 43, :_reduce_none,
  1, 43, :_reduce_none,
  1, 43, :_reduce_none,
  1, 43, :_reduce_none,
  1, 43, :_reduce_none,
  1, 43, :_reduce_none,
  1, 43, :_reduce_none,
  2, 44, :_reduce_68,
  1, 44, :_reduce_69,
  3, 34, :_reduce_70,
  3, 38, :_reduce_71,
  3, 39, :_reduce_72,
  1, 46, :_reduce_73,
  2, 47, :_reduce_74,
  1, 47, :_reduce_75,
  3, 32, :_reduce_76,
  1, 48, :_reduce_77,
  2, 49, :_reduce_78,
  1, 49, :_reduce_79,
  3, 33, :_reduce_80,
  1, 45, :_reduce_none,
  1, 45, :_reduce_none,
  1, 45, :_reduce_none,
  1, 45, :_reduce_none,
  1, 45, :_reduce_none,
  1, 45, :_reduce_none,
  1, 45, :_reduce_none,
  1, 45, :_reduce_none,
  1, 45, :_reduce_none,
  1, 45, :_reduce_none,
  1, 45, :_reduce_none,
  1, 45, :_reduce_none,
  1, 45, :_reduce_none,
  1, 45, :_reduce_none,
  1, 45, :_reduce_none,
  1, 45, :_reduce_none,
  1, 45, :_reduce_none,
  1, 45, :_reduce_none,
  1, 45, :_reduce_none,
  1, 45, :_reduce_none,
  1, 45, :_reduce_none,
  1, 45, :_reduce_none,
  1, 50, :_reduce_none,
  2, 50, :_reduce_104,
  3, 37, :_reduce_105,
  1, 40, :_reduce_106,
  2, 40, :_reduce_107,
  1, 51, :_reduce_108 ]

racc_reduce_n = 109

racc_shift_n = 133

racc_token_table = {
  false => 0,
  :error => 1,
  :EM_OPEN => 2,
  :EM_CLOSE => 3,
  :ITALIC_OPEN => 4,
  :ITALIC_CLOSE => 5,
  :STRIKE_OPEN => 6,
  :STRIKE_CLOSE => 7,
  :LABEL_OPEN => 8,
  :LABEL_CLOSE => 9,
  :REFERENCE_OPEN => 10,
  :REFERENCE_CLOSE => 11,
  :VERB_OPEN => 12,
  :VERB_CLOSE => 13,
  :ERB_OPEN => 14,
  :ERB_CLOSE => 15,
  :FOOTNOTE_OPEN => 16,
  :FOOTNOTE_CLOSE => 17,
  :RUBY_OPEN => 18,
  :RUBY_CLOSE => 19,
  :IMAGE_OPEN => 20,
  :IMAGE_CLOSE => 21,
  :MANUEDO_OPEN => 22,
  :MANUEDO_CLOSE => 23,
  :OTHER => 24 }

racc_nt_base = 25

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
  "EM_OPEN",
  "EM_CLOSE",
  "ITALIC_OPEN",
  "ITALIC_CLOSE",
  "STRIKE_OPEN",
  "STRIKE_CLOSE",
  "LABEL_OPEN",
  "LABEL_CLOSE",
  "REFERENCE_OPEN",
  "REFERENCE_CLOSE",
  "VERB_OPEN",
  "VERB_CLOSE",
  "ERB_OPEN",
  "ERB_CLOSE",
  "FOOTNOTE_OPEN",
  "FOOTNOTE_CLOSE",
  "RUBY_OPEN",
  "RUBY_CLOSE",
  "IMAGE_OPEN",
  "IMAGE_CLOSE",
  "MANUEDO_OPEN",
  "MANUEDO_CLOSE",
  "OTHER",
  "$start",
  "content",
  "elements",
  "element",
  "emphasis",
  "italic",
  "strike",
  "label",
  "reference",
  "ruby",
  "footnote",
  "image",
  "verb",
  "erb",
  "manuedo",
  "normal_strings",
  "image_string",
  "image_strings",
  "ruby_string",
  "ruby_strings",
  "verb_string",
  "label_string",
  "label_strings",
  "reference_string",
  "reference_strings",
  "verb_strings",
  "normal_string" ]

Racc_debug_parser = false

##### State transition tables end #####

# reduce 0 omitted

# reduce 1 omitted

# reduce 2 omitted

module_eval(<<'.,.,', 'rafinlineparser.ry', 9)
  def _reduce_3(val, _values)
     val[0].push(val[1]) 
  end
.,.,

module_eval(<<'.,.,', 'rafinlineparser.ry', 10)
  def _reduce_4(val, _values)
     val 
  end
.,.,

# reduce 5 omitted

# reduce 6 omitted

# reduce 7 omitted

# reduce 8 omitted

# reduce 9 omitted

# reduce 10 omitted

# reduce 11 omitted

# reduce 12 omitted

# reduce 13 omitted

# reduce 14 omitted

# reduce 15 omitted

# reduce 16 omitted

module_eval(<<'.,.,', 'rafinlineparser.ry', 26)
  def _reduce_17(val, _values)
     Emphasis.new(val[1]) 
  end
.,.,

module_eval(<<'.,.,', 'rafinlineparser.ry', 27)
  def _reduce_18(val, _values)
     Italic.new(val[1]) 
  end
.,.,

module_eval(<<'.,.,', 'rafinlineparser.ry', 28)
  def _reduce_19(val, _values)
     Strike.new(val[1]) 
  end
.,.,

module_eval(<<'.,.,', 'rafinlineparser.ry', 30)
  def _reduce_20(val, _values)
                   @index[:footnote] ||= []
               @index[:footnote] << {:content => val[1] }
               Footnote.new([val[1], @index[:footnote].size])
               
  end
.,.,

# reduce 21 omitted

# reduce 22 omitted

# reduce 23 omitted

# reduce 24 omitted

# reduce 25 omitted

# reduce 26 omitted

# reduce 27 omitted

# reduce 28 omitted

# reduce 29 omitted

# reduce 30 omitted

# reduce 31 omitted

# reduce 32 omitted

# reduce 33 omitted

# reduce 34 omitted

# reduce 35 omitted

# reduce 36 omitted

# reduce 37 omitted

# reduce 38 omitted

# reduce 39 omitted

# reduce 40 omitted

# reduce 41 omitted

# reduce 42 omitted

module_eval(<<'.,.,', 'rafinlineparser.ry', 61)
  def _reduce_43(val, _values)
     val.join 
  end
.,.,

module_eval(<<'.,.,', 'rafinlineparser.ry', 62)
  def _reduce_44(val, _values)
     val[0] 
  end
.,.,

module_eval(<<'.,.,', 'rafinlineparser.ry', 63)
  def _reduce_45(val, _values)
     Image.new(val[1]) 
  end
.,.,

# reduce 46 omitted

# reduce 47 omitted

# reduce 48 omitted

# reduce 49 omitted

# reduce 50 omitted

# reduce 51 omitted

# reduce 52 omitted

# reduce 53 omitted

# reduce 54 omitted

# reduce 55 omitted

# reduce 56 omitted

# reduce 57 omitted

# reduce 58 omitted

# reduce 59 omitted

# reduce 60 omitted

# reduce 61 omitted

# reduce 62 omitted

# reduce 63 omitted

# reduce 64 omitted

# reduce 65 omitted

# reduce 66 omitted

# reduce 67 omitted

module_eval(<<'.,.,', 'rafinlineparser.ry', 90)
  def _reduce_68(val, _values)
     val.join 
  end
.,.,

module_eval(<<'.,.,', 'rafinlineparser.ry', 91)
  def _reduce_69(val, _values)
     val[0] 
  end
.,.,

module_eval(<<'.,.,', 'rafinlineparser.ry', 94)
  def _reduce_70(val, _values)
                      base, text = val[1].split("|",2)
                  text ||= base
                  Ruby.new([base, text])
                
  end
.,.,

module_eval(<<'.,.,', 'rafinlineparser.ry', 102)
  def _reduce_71(val, _values)
                 e = ERB.new("<%= #{val[1]} %>")
             Plain.new(e.result) 
  end
.,.,

module_eval(<<'.,.,', 'rafinlineparser.ry', 106)
  def _reduce_72(val, _values)
     Manuedo.new(val[1]) 
  end
.,.,

module_eval(<<'.,.,', 'rafinlineparser.ry', 111)
  def _reduce_73(val, _values)
     val[0] 
  end
.,.,

module_eval(<<'.,.,', 'rafinlineparser.ry', 114)
  def _reduce_74(val, _values)
     val.join 
  end
.,.,

module_eval(<<'.,.,', 'rafinlineparser.ry', 115)
  def _reduce_75(val, _values)
     val[0] 
  end
.,.,

module_eval(<<'.,.,', 'rafinlineparser.ry', 118)
  def _reduce_76(val, _values)
              label, title = val[1].split("|",2)
          title ||= label
          @index[:label] ||= []
          @index[:label] << {:title => title }
          Label.new([label.to_code, title, @index[:label].size])
          
  end
.,.,

module_eval(<<'.,.,', 'rafinlineparser.ry', 127)
  def _reduce_77(val, _values)
     val[0] 
  end
.,.,

module_eval(<<'.,.,', 'rafinlineparser.ry', 129)
  def _reduce_78(val, _values)
     val.join 
  end
.,.,

module_eval(<<'.,.,', 'rafinlineparser.ry', 130)
  def _reduce_79(val, _values)
     val[0] 
  end
.,.,

module_eval(<<'.,.,', 'rafinlineparser.ry', 133)
  def _reduce_80(val, _values)
                      title, uri = val[1].split("|",2)
                  uri ||= title
                  uri = "#" + uri.to_code if uri.gsub(/^\s*https*:\/\//,"") == uri
                  Reference.new([title, uri])
                
  end
.,.,

# reduce 81 omitted

# reduce 82 omitted

# reduce 83 omitted

# reduce 84 omitted

# reduce 85 omitted

# reduce 86 omitted

# reduce 87 omitted

# reduce 88 omitted

# reduce 89 omitted

# reduce 90 omitted

# reduce 91 omitted

# reduce 92 omitted

# reduce 93 omitted

# reduce 94 omitted

# reduce 95 omitted

# reduce 96 omitted

# reduce 97 omitted

# reduce 98 omitted

# reduce 99 omitted

# reduce 100 omitted

# reduce 101 omitted

# reduce 102 omitted

# reduce 103 omitted

module_eval(<<'.,.,', 'rafinlineparser.ry', 164)
  def _reduce_104(val, _values)
     val 
  end
.,.,

module_eval(<<'.,.,', 'rafinlineparser.ry', 166)
  def _reduce_105(val, _values)
      Verb.new(val[1])
  end
.,.,

module_eval(<<'.,.,', 'rafinlineparser.ry', 170)
  def _reduce_106(val, _values)
     Plain.new(val[0]) 
  end
.,.,

module_eval(<<'.,.,', 'rafinlineparser.ry', 171)
  def _reduce_107(val, _values)
      Plain.new([val[0].contents, val[1]]) 
  end
.,.,

module_eval(<<'.,.,', 'rafinlineparser.ry', 173)
  def _reduce_108(val, _values)
     val[0] 
  end
.,.,

def _reduce_none(val, _values)
  val[0]
end

end   # class InlineParser

  if __FILE__ == $0
    raf = InlineParser.new
    src = $stdin.readline
    nodes = raf.parse(src)
    puts "----- output -----"
    nodes.each do |n|
      puts n.apply
    end
  end
end # end of module Raf
