#
# DO NOT MODIFY!!!!
# This file is automatically generated by Racc 1.4.6
# from Racc grammer file "".
#

require 'racc/parser.rb'

require "parserutility"
require 'strscan'
require 'erb'
require 'rafelement'

module Raf
class InlineParser < Racc::Parser

module_eval(<<'...end rafinlineparser.ry/module_eval...', 'rafinlineparser.ry', 203)
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

REFERENCE_HTML_OPEN = '((&lt;'
REFERENCE_HTML_OPEN_RE = /\A#{Regexp.quote(REFERENCE_HTML_OPEN)}/
REFERENCE_HTML_CLOSE = '&gt;))'
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

BAR = "|"
BAR_RE = /\A#{Regexp.quote(BAR)}/
QUOTE = '"'
QUOTE_RE = /\A#{Regexp.quote(QUOTE)}/
SLASH = "/"
SLASH_RE = /\A#{Regexp.quote(SLASH)}/
BACK_SLASH = "\\"
BACK_SLASH_RE = /\A#{Regexp.quote(BACK_SLASH)}/
# URL = "URL:"
# URL_RE = /\A#{Regexp.quote(URL)}/

#other_re_mode = Regexp::EXTENDED
other_re_mode = Regexp::MULTILINE
OTHER_RE = Regexp.new(
                      "\\A.+?(?=#{Regexp.quote(EM_OPEN)}|#{Regexp.quote(EM_CLOSE)}|#{Regexp.quote(ITALIC_OPEN)}|#{Regexp.quote(ITALIC_CLOSE)}|#{Regexp.quote(STRIKE_OPEN)}|#{Regexp.quote(STRIKE_CLOSE)}|#{Regexp.quote(FOOTNOTE_OPEN)}|#{Regexp.quote(FOOTNOTE_CLOSE)}|#{Regexp.quote(RUBY_OPEN)}|#{Regexp.quote(RUBY_CLOSE)}|#{Regexp.quote(IMAGE_OPEN)}|#{Regexp.quote(IMAGE_CLOSE)}|#{Regexp.quote(LABEL_OPEN)}|#{Regexp.quote(LABEL_CLOSE)}|#{Regexp.quote(LABEL_HTML_OPEN)}|#{Regexp.quote(LABEL_HTML_CLOSE)}|#{Regexp.quote(REFERENCE_OPEN)}|#{Regexp.quote(REFERENCE_CLOSE)}|#{Regexp.quote(REFERENCE_HTML_OPEN)}|#{Regexp.quote(REFERENCE_HTML_CLOSE)}|#{Regexp.quote(MANUEDO_OPEN)}|#{Regexp.quote(MANUEDO_CLOSE)}|#{Regexp.quote(VERB_OPEN)}|#{Regexp.quote(VERB_CLOSE)}|#{Regexp.quote(ERB_OPEN)}|#{Regexp.quote(ERB_CLOSE)}|#{Regexp.quote(BAR)}|#{Regexp.quote(QUOTE)}|#{Regexp.quote(SLASH)}|#{Regexp.quote(BACK_SLASH)})", other_re_mode)


def parse(src)
  @src = StringScanner.new(src.to_s)
  @pre = ""
  @@yydebug = true
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
  elsif ret = @src.scan(BAR_RE)
    puts "i: BAR: #{ret}" if @view_token_type
    @pre << ret
    [:BAR, ret]
  elsif ret = @src.scan(QUOTE_RE)
    puts "i: QUOTE: #{ret}" if @view_token_type
    @pre << ret
    [:QUOTE, ret]
  elsif ret = @src.scan(SLASH_RE)
    puts "i: SLASH: #{ret}" if @view_token_type
    @pre << ret
    [:SLASH, ret]
  elsif ret = @src.scan(BACK_SLASH_RE)
    puts "i: BACK_SLASH: #{ret}" if @view_token_type
    @pre << ret
    [:BACK_SLASH, ret]
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
     8,   145,    14,   144,    20,   147,    24,   143,    30,   103,
     5,   152,    11,   140,    17,   146,    22,   nil,    27,   nil,
     2,   nil,     7,    10,    13,    16,    19,     8,   nil,    14,
   nil,    20,   nil,    24,   nil,    30,   nil,     5,   nil,    11,
   nil,    17,   nil,    22,   nil,    27,   nil,     2,   nil,     7,
    10,    13,    16,    19,   111,   114,   117,   120,   123,   126,
   127,   130,   131,   104,   107,   110,   113,   116,   119,   122,
   125,   128,   129,   154,   105,   108,   112,   115,   118,   121,
   124,    39,    42,    45,    49,    52,    55,    57,    58,    61,
    35,    37,   nil,    41,    44,    48,    51,    54,    56,    59,
    62,    36,    38,    40,    43,    46,    50,    53,     8,   nil,
    14,   nil,    20,   nil,    24,   nil,    30,   nil,     5,   nil,
    11,   nil,    17,   nil,    22,   nil,    27,   nil,     2,   nil,
     7,    10,    13,    16,    19,    39,    42,    45,    49,    52,
    55,    57,    58,    61,    35,    37,   nil,    41,    44,    48,
    51,    54,    56,    59,    62,    36,    38,    40,    43,    46,
    50,    53,     8,   nil,    14,   nil,    20,   nil,    24,   nil,
    30,   nil,     5,   nil,    11,   nil,    17,   nil,    22,   nil,
    27,   nil,     2,   nil,     7,    10,    13,    16,    19,     8,
   nil,    14,   nil,    20,   nil,    24,   nil,    30,   nil,     5,
   nil,    11,   nil,    17,   nil,    22,   nil,    27,   nil,     2,
   nil,     7,    10,    13,    16,    19,     8,   nil,    14,   nil,
    20,   nil,    24,   nil,    30,   nil,     5,   nil,    11,   nil,
    17,   nil,    22,   nil,    27,   nil,     2,   nil,     7,    10,
    13,    16,    19,    73,    77,    81,    84,    87,    90,    91,
    92,    94,    68,    70,    72,    76,    80,    83,    86,    89,
   nil,    93,    95,    69,    71,    74,    78,    82,    85,    88,
    73,    77,    81,    84,    87,    90,    91,    92,    94,    68,
    70,    72,    76,    80,    83,    86,    89,   149,    93,    95,
    69,    71,    74,    78,    82,    85,    88,    39,    42,    45,
    49,    52,    55,    57,    58,    61,    35,    37,   141,    41,
    44,    48,    51,    54,    56,    59,    62,    36,    38,    40,
    43,    46,    50,    53,   111,   114,   117,   120,   123,   126,
   127,   130,   131,   104,   107,   110,   113,   116,   119,   122,
   125,   128,   129,   nil,   105,   108,   112,   115,   118,   121,
   124,     8,   nil,    14,   nil,    20,   nil,    24,   nil,    30,
   nil,     5,   nil,    11,   151,    17,   nil,    22,   nil,    27,
   nil,     2,   155,     7,    10,    13,    16,    19,   nil,    96,
    97,    98,    99,   101,   nil,   133,   134,   135,   136,   137,
     7,    10,    13,    16,    19,    96,    97,    98,    99,   101,
   133,   134,   135,   136,   137 ]

racc_action_check = [
     0,    65,     0,    64,     0,    67,     0,    63,     0,    26,
     0,   103,     0,    33,     0,    66,     0,   nil,     0,   nil,
     0,   nil,     0,     0,     0,     0,     0,     2,   nil,     2,
   nil,     2,   nil,     2,   nil,     2,   nil,     2,   nil,     2,
   nil,     2,   nil,     2,   nil,     2,   nil,     2,   nil,     2,
     2,     2,     2,     2,   109,   109,   109,   109,   109,   109,
   109,   109,   109,   109,   109,   109,   109,   109,   109,   109,
   109,   109,   109,   109,   109,   109,   109,   109,   109,   109,
   109,     5,     5,     5,     5,     5,     5,     5,     5,     5,
     5,     5,   nil,     5,     5,     5,     5,     5,     5,     5,
     5,     5,     5,     5,     5,     5,     5,     5,     8,   nil,
     8,   nil,     8,   nil,     8,   nil,     8,   nil,     8,   nil,
     8,   nil,     8,   nil,     8,   nil,     8,   nil,     8,   nil,
     8,     8,     8,     8,     8,    11,    11,    11,    11,    11,
    11,    11,    11,    11,    11,    11,   nil,    11,    11,    11,
    11,    11,    11,    11,    11,    11,    11,    11,    11,    11,
    11,    11,    14,   nil,    14,   nil,    14,   nil,    14,   nil,
    14,   nil,    14,   nil,    14,   nil,    14,   nil,    14,   nil,
    14,   nil,    14,   nil,    14,    14,    14,    14,    14,    17,
   nil,    17,   nil,    17,   nil,    17,   nil,    17,   nil,    17,
   nil,    17,   nil,    17,   nil,    17,   nil,    17,   nil,    17,
   nil,    17,    17,    17,    17,    17,    20,   nil,    20,   nil,
    20,   nil,    20,   nil,    20,   nil,    20,   nil,    20,   nil,
    20,   nil,    20,   nil,    20,   nil,    20,   nil,    20,    20,
    20,    20,    20,    22,    22,    22,    22,    22,    22,    22,
    22,    22,    22,    22,    22,    22,    22,    22,    22,    22,
   nil,    22,    22,    22,    22,    22,    22,    22,    22,    22,
    79,    79,    79,    79,    79,    79,    79,    79,    79,    79,
    79,    79,    79,    79,    79,    79,    79,    79,    79,    79,
    79,    79,    79,    79,    79,    79,    79,    60,    60,    60,
    60,    60,    60,    60,    60,    60,    60,    60,    60,    60,
    60,    60,    60,    60,    60,    60,    60,    60,    60,    60,
    60,    60,    60,    60,    27,    27,    27,    27,    27,    27,
    27,    27,    27,    27,    27,    27,    27,    27,    27,    27,
    27,    27,    27,   nil,    27,    27,    27,    27,    27,    27,
    27,    29,   nil,    29,   nil,    29,   nil,    29,   nil,    29,
   nil,    29,   nil,    29,   102,    29,   nil,    29,   nil,    29,
   nil,    29,   139,    29,    29,    29,    29,    29,   nil,   102,
   102,   102,   102,   102,   nil,   139,   139,   139,   139,   139,
     3,     3,     3,     3,     3,    24,    24,    24,    24,    24,
    30,    30,    30,    30,    30 ]

racc_action_pointer = [
    -2,   nil,    25,   366,   nil,    79,   nil,   nil,   106,   nil,
   nil,   133,   nil,   nil,   160,   nil,   nil,   187,   nil,   nil,
   214,   nil,   241,   nil,   371,   nil,     9,   322,   nil,   349,
   376,   nil,   nil,   -10,   nil,   nil,   nil,   nil,   nil,   nil,
   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,
   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,
   295,   nil,   nil,     4,   -12,    -4,    -2,    -2,   nil,   nil,
   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   268,
   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,
   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,
   nil,   nil,   355,    11,   nil,   nil,   nil,   nil,   nil,    52,
   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,
   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,
   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   361,
   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,
   nil,   nil,   nil,   nil,   nil,   nil,   nil ]

racc_action_default = [
    -1,  -126,    -1,   -16,    -5,  -133,    -6,  -130,    -1,    -7,
  -129,  -133,    -8,  -131,    -1,    -9,  -132,    -1,   -10,  -128,
    -1,   -11,  -133,   -12,  -133,   -13,  -133,  -133,   -14,    -2,
  -133,   -15,    -4,  -133,  -127,  -115,  -110,  -122,  -111,  -102,
   -99,  -112,  -103,   -98,  -113,  -104,  -100,  -123,  -120,  -105,
  -101,  -121,  -106,   -97,  -118,  -107,  -119,  -116,  -117,  -108,
  -133,  -114,  -109,  -133,  -133,  -133,  -133,  -133,   -68,   -63,
   -74,   -64,   -75,   -55,   -52,   -77,   -65,   -56,   -51,  -133,
   -66,   -57,   -53,   -72,   -58,   -54,   -73,   -59,   -50,   -71,
   -60,   -69,   -70,   -61,   -67,   -62,   -83,   -82,   -84,   -85,
   -87,   -81,  -133,  -133,   -39,   -34,   -48,   -44,   -35,  -133,
   -45,   -26,   -23,   -36,   -27,   -22,   -37,   -28,   -24,   -42,
   -29,   -25,   -43,   -30,   -21,   -32,   -31,   -40,   -33,   -46,
   -41,   -38,    -3,   -91,   -90,   -92,   -93,   -89,   -95,  -133,
   -80,  -125,  -124,   -17,   -79,   -18,   -20,   -19,   -76,   -78,
   -86,   -88,   157,   -47,   -49,   -96,   -94 ]

racc_goto_table = [
   138,   106,   100,    75,    47,    26,    79,    33,   109,   102,
    64,   132,   139,    63,    60,    34,   nil,   nil,   nil,    65,
   nil,   nil,    66,   nil,   nil,    67,   nil,   nil,   nil,   nil,
   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,
   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,
   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   142,
   148,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,
   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,
   150,   nil,   nil,   153,   nil,   nil,   nil,   nil,   nil,   nil,
   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,
   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   156 ]

racc_goto_check = [
    23,    16,    21,    18,    20,     1,    19,     1,    17,    22,
    20,     3,    24,     1,    25,    26,   nil,   nil,   nil,     1,
   nil,   nil,     1,   nil,   nil,     1,   nil,   nil,   nil,   nil,
   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,
   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,
   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,    20,
    18,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,
   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,
    21,   nil,   nil,    16,   nil,   nil,   nil,   nil,   nil,   nil,
   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,
   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,    23 ]

racc_goto_pointer = [
   nil,     5,   nil,   -18,   nil,   nil,   nil,   nil,   nil,   nil,
   nil,   nil,   nil,   nil,   nil,   nil,   -26,   -19,   -19,   -16,
    -1,   -22,   -15,   -30,   -18,     9,    12 ]

racc_goto_default = [
   nil,   nil,    29,    32,     4,     6,     9,    12,    15,    18,
    21,    23,    25,    28,    31,     3,   nil,   nil,   nil,   nil,
   nil,   nil,   nil,   nil,   nil,   nil,     1 ]

racc_reduce_table = [
  0, 0, :racc_error,
  0, 30, :_reduce_none,
  1, 30, :_reduce_none,
  2, 31, :_reduce_3,
  1, 31, :_reduce_4,
  1, 32, :_reduce_none,
  1, 32, :_reduce_none,
  1, 32, :_reduce_none,
  1, 32, :_reduce_none,
  1, 32, :_reduce_none,
  1, 32, :_reduce_none,
  1, 32, :_reduce_none,
  1, 32, :_reduce_none,
  1, 32, :_reduce_none,
  1, 32, :_reduce_none,
  1, 32, :_reduce_none,
  1, 32, :_reduce_none,
  3, 33, :_reduce_17,
  3, 34, :_reduce_18,
  3, 35, :_reduce_19,
  3, 39, :_reduce_20,
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
  1, 45, :_reduce_none,
  1, 45, :_reduce_none,
  1, 45, :_reduce_none,
  1, 45, :_reduce_none,
  2, 46, :_reduce_47,
  1, 46, :_reduce_48,
  3, 40, :_reduce_49,
  1, 47, :_reduce_none,
  1, 47, :_reduce_none,
  1, 47, :_reduce_none,
  1, 47, :_reduce_none,
  1, 47, :_reduce_none,
  1, 47, :_reduce_none,
  1, 47, :_reduce_none,
  1, 47, :_reduce_none,
  1, 47, :_reduce_none,
  1, 47, :_reduce_none,
  1, 47, :_reduce_none,
  1, 47, :_reduce_none,
  1, 47, :_reduce_none,
  1, 47, :_reduce_none,
  1, 47, :_reduce_none,
  1, 47, :_reduce_none,
  1, 47, :_reduce_none,
  1, 47, :_reduce_none,
  1, 47, :_reduce_none,
  1, 47, :_reduce_none,
  1, 47, :_reduce_none,
  1, 47, :_reduce_none,
  1, 47, :_reduce_none,
  1, 47, :_reduce_none,
  1, 47, :_reduce_none,
  1, 47, :_reduce_none,
  2, 48, :_reduce_76,
  1, 48, :_reduce_77,
  3, 38, :_reduce_78,
  3, 42, :_reduce_79,
  3, 43, :_reduce_80,
  1, 50, :_reduce_81,
  1, 50, :_reduce_82,
  1, 50, :_reduce_83,
  1, 50, :_reduce_84,
  1, 50, :_reduce_85,
  2, 51, :_reduce_86,
  1, 51, :_reduce_87,
  3, 36, :_reduce_88,
  1, 52, :_reduce_89,
  1, 52, :_reduce_90,
  1, 52, :_reduce_91,
  1, 52, :_reduce_92,
  1, 52, :_reduce_93,
  2, 53, :_reduce_94,
  1, 53, :_reduce_95,
  3, 37, :_reduce_96,
  1, 49, :_reduce_none,
  1, 49, :_reduce_none,
  1, 49, :_reduce_none,
  1, 49, :_reduce_none,
  1, 49, :_reduce_none,
  1, 49, :_reduce_none,
  1, 49, :_reduce_none,
  1, 49, :_reduce_none,
  1, 49, :_reduce_none,
  1, 49, :_reduce_none,
  1, 49, :_reduce_none,
  1, 49, :_reduce_none,
  1, 49, :_reduce_none,
  1, 49, :_reduce_none,
  1, 49, :_reduce_none,
  1, 49, :_reduce_none,
  1, 49, :_reduce_none,
  1, 49, :_reduce_none,
  1, 49, :_reduce_none,
  1, 49, :_reduce_none,
  1, 49, :_reduce_none,
  1, 49, :_reduce_none,
  1, 49, :_reduce_none,
  1, 49, :_reduce_none,
  1, 49, :_reduce_none,
  1, 49, :_reduce_none,
  1, 54, :_reduce_none,
  2, 54, :_reduce_124,
  3, 41, :_reduce_125,
  1, 44, :_reduce_126,
  2, 44, :_reduce_127,
  1, 55, :_reduce_128,
  1, 55, :_reduce_129,
  1, 55, :_reduce_130,
  1, 55, :_reduce_131,
  1, 55, :_reduce_132 ]

racc_reduce_n = 133

racc_shift_n = 157

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
  :BAR => 24,
  :QUOTE => 25,
  :SLASH => 26,
  :BACK_SLASH => 27,
  :OTHER => 28 }

racc_nt_base = 29

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
  "BAR",
  "QUOTE",
  "SLASH",
  "BACK_SLASH",
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

module_eval(<<'.,.,', 'rafinlineparser.ry', 27)
  def _reduce_17(val, _values)
     Emphasis.new(val[1]) 
  end
.,.,

module_eval(<<'.,.,', 'rafinlineparser.ry', 28)
  def _reduce_18(val, _values)
     Italic.new(val[1]) 
  end
.,.,

module_eval(<<'.,.,', 'rafinlineparser.ry', 29)
  def _reduce_19(val, _values)
     Strike.new(val[1]) 
  end
.,.,

module_eval(<<'.,.,', 'rafinlineparser.ry', 31)
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

# reduce 43 omitted

# reduce 44 omitted

# reduce 45 omitted

# reduce 46 omitted

module_eval(<<'.,.,', 'rafinlineparser.ry', 67)
  def _reduce_47(val, _values)
     val.to_s 
  end
.,.,

module_eval(<<'.,.,', 'rafinlineparser.ry', 68)
  def _reduce_48(val, _values)
     val[0] 
  end
.,.,

module_eval(<<'.,.,', 'rafinlineparser.ry', 69)
  def _reduce_49(val, _values)
     Image.new(val[1]) 
  end
.,.,

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

# reduce 68 omitted

# reduce 69 omitted

# reduce 70 omitted

# reduce 71 omitted

# reduce 72 omitted

# reduce 73 omitted

# reduce 74 omitted

# reduce 75 omitted

module_eval(<<'.,.,', 'rafinlineparser.ry', 100)
  def _reduce_76(val, _values)
     val.to_s 
  end
.,.,

module_eval(<<'.,.,', 'rafinlineparser.ry', 101)
  def _reduce_77(val, _values)
     val[0] 
  end
.,.,

module_eval(<<'.,.,', 'rafinlineparser.ry', 104)
  def _reduce_78(val, _values)
                      base, text = val[1].split("|",2)
                  text ||= base
                  Ruby.new([base, text])
                
  end
.,.,

module_eval(<<'.,.,', 'rafinlineparser.ry', 112)
  def _reduce_79(val, _values)
                 e = ERB.new("<%= #{val[1]} %>")
             Plain.new(e.result) 
  end
.,.,

module_eval(<<'.,.,', 'rafinlineparser.ry', 116)
  def _reduce_80(val, _values)
     Manuedo.new(val[1]) 
  end
.,.,

module_eval(<<'.,.,', 'rafinlineparser.ry', 121)
  def _reduce_81(val, _values)
     val[0] 
  end
.,.,

module_eval(<<'.,.,', 'rafinlineparser.ry', 122)
  def _reduce_82(val, _values)
     val[0] 
  end
.,.,

module_eval(<<'.,.,', 'rafinlineparser.ry', 123)
  def _reduce_83(val, _values)
     val[0] 
  end
.,.,

module_eval(<<'.,.,', 'rafinlineparser.ry', 124)
  def _reduce_84(val, _values)
     val[0] 
  end
.,.,

module_eval(<<'.,.,', 'rafinlineparser.ry', 125)
  def _reduce_85(val, _values)
     val[0] 
  end
.,.,

module_eval(<<'.,.,', 'rafinlineparser.ry', 127)
  def _reduce_86(val, _values)
     val.to_s 
  end
.,.,

module_eval(<<'.,.,', 'rafinlineparser.ry', 128)
  def _reduce_87(val, _values)
     val[0] 
  end
.,.,

module_eval(<<'.,.,', 'rafinlineparser.ry', 131)
  def _reduce_88(val, _values)
              label, title = val[1].split("|",2)
          title ||= label
          @index[:label] ||= []
          @index[:label] << {:title => title }
          Label.new([label.to_code, title, @index[:label].size])
          
  end
.,.,

module_eval(<<'.,.,', 'rafinlineparser.ry', 140)
  def _reduce_89(val, _values)
     val[0] 
  end
.,.,

module_eval(<<'.,.,', 'rafinlineparser.ry', 141)
  def _reduce_90(val, _values)
     val[0] 
  end
.,.,

module_eval(<<'.,.,', 'rafinlineparser.ry', 142)
  def _reduce_91(val, _values)
     val[0] 
  end
.,.,

module_eval(<<'.,.,', 'rafinlineparser.ry', 143)
  def _reduce_92(val, _values)
     val[0] 
  end
.,.,

module_eval(<<'.,.,', 'rafinlineparser.ry', 144)
  def _reduce_93(val, _values)
     val[0] 
  end
.,.,

module_eval(<<'.,.,', 'rafinlineparser.ry', 146)
  def _reduce_94(val, _values)
     val.to_s 
  end
.,.,

module_eval(<<'.,.,', 'rafinlineparser.ry', 147)
  def _reduce_95(val, _values)
     val[0] 
  end
.,.,

module_eval(<<'.,.,', 'rafinlineparser.ry', 150)
  def _reduce_96(val, _values)
                      title, uri = val[1].split("|",2)
                  uri ||= title
                  uri = "#" + uri.to_code if uri.gsub(/^\s*https*:\/\//,"") == uri
                  Reference.new([title, uri])
                
  end
.,.,

# reduce 97 omitted

# reduce 98 omitted

# reduce 99 omitted

# reduce 100 omitted

# reduce 101 omitted

# reduce 102 omitted

# reduce 103 omitted

# reduce 104 omitted

# reduce 105 omitted

# reduce 106 omitted

# reduce 107 omitted

# reduce 108 omitted

# reduce 109 omitted

# reduce 110 omitted

# reduce 111 omitted

# reduce 112 omitted

# reduce 113 omitted

# reduce 114 omitted

# reduce 115 omitted

# reduce 116 omitted

# reduce 117 omitted

# reduce 118 omitted

# reduce 119 omitted

# reduce 120 omitted

# reduce 121 omitted

# reduce 122 omitted

# reduce 123 omitted

module_eval(<<'.,.,', 'rafinlineparser.ry', 185)
  def _reduce_124(val, _values)
     val 
  end
.,.,

module_eval(<<'.,.,', 'rafinlineparser.ry', 187)
  def _reduce_125(val, _values)
      Verb.new(val[1])
  end
.,.,

module_eval(<<'.,.,', 'rafinlineparser.ry', 191)
  def _reduce_126(val, _values)
     Plain.new(val[0]) 
  end
.,.,

module_eval(<<'.,.,', 'rafinlineparser.ry', 192)
  def _reduce_127(val, _values)
      Plain.new([val[0].contents, val[1]]) 
  end
.,.,

module_eval(<<'.,.,', 'rafinlineparser.ry', 194)
  def _reduce_128(val, _values)
     val[0] 
  end
.,.,

module_eval(<<'.,.,', 'rafinlineparser.ry', 195)
  def _reduce_129(val, _values)
     val[0] 
  end
.,.,

module_eval(<<'.,.,', 'rafinlineparser.ry', 196)
  def _reduce_130(val, _values)
     val[0] 
  end
.,.,

module_eval(<<'.,.,', 'rafinlineparser.ry', 197)
  def _reduce_131(val, _values)
     val[0] 
  end
.,.,

module_eval(<<'.,.,', 'rafinlineparser.ry', 198)
  def _reduce_132(val, _values)
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
