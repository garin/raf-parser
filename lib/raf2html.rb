# -*- coding: utf-8 -*-
# Copyright (C) garin <garin54@gmail.com> 2011
# See the included file COPYING for details.
require "raf2html_element"
require "cgi"

module Raf
  class Raf2Html
    def initialize(src, options = {})
      @debug = true

      # options
      @css = File.open(options[:css]).readlines.to_s unless options[:css].nil?
      @language = options[:language]
      @index = options[:index]
      @metadata = options[:metadata]
      @quiet = options[:quiet]

      @raf = BlockParser.new
      @metadata = setup_metadata
      @nodes = @raf.parse src
    end

    def setup_metadata
      metadata = @raf.metadata
      metadata[:language] = @language if metadata[:language].nil?
      metadata
    end

    def to_html
      html = ""
      html += header unless @quiet
      html += header_title
      html += metadata if @metadata
      html += index if @index
      html += body
      html += footnote
      html += footer unless @quiet
      html
    end

    def body
      @nodes.map do |node| node.apply end.join
    end


    def index
      return "" if @raf.index[:head].nil?
      str = "<div id='raf-index'>"
      level_pre = 1
      @raf.index[:head].each_with_index do |h,i|
        next if h[:level] == 1 or h[:level] == 6

        if h[:level] == 5
          str += "<div class=><a href='#raf-head#{h[:level]}-#{i+1}'><span class='space' />#{h[:title]}</a></div>\n"
        else
          str += index_terminate(h[:level], level_pre)
          str += "<li><a href='#raf-head#{h[:level]}-#{i+1}'>#{h[:index]}#{h[:title]}</a>\n"
          level_pre = h[:level]
        end
      end
      str += index_terminate(2, level_pre) + "</ul>"
      str += "</div>"
      str
    end

    def index_terminate(level, level_pre)
      str = ""
      case level <=> level_pre
      when 1
        (level - level_pre).times do
          str += "<ul>"
        end
      when -1
        (level_pre - level).times do
          str += "</ul></li>"
        end
      else
        str += "</li>"
      end
      str
    end

    def metadata
      str = "<div id='raf-metadata'>"
      str += "<table id='raf-metadata-table'>"
      str_pre = ""
      str_pre += "<tr><th>著者</th><td colspan='3'>#{@metadata[:creator]}</td></tr>" unless @metadata[:creator].nil?
      str_pre += "<tr><th>公開日</th><td>#{@metadata[:date]}</td></tr>"  unless @metadata[:date].nil?
      str_pre += "<tr><th>更新日</th><td>#{@metadata[:update]}</td></tr>" unless @metadata[:update].nil?
      str_pre += "<tr><th>タグ</th><td>#{@metadata[:tag]}</td></tr>" unless @metadata[:tag].nil?
      str_pre += "<tr><th>発行</th><td>#{@metadata[:publisher]}</td></tr>" unless @metadata[:publisher].nil?
      str_pre += "<tr><th>バージョン</th><td>#{@metadata[:version]}</td></tr>" unless @metadata[:version].nil?
      str_pre += "<tr><th>寄稿者</th>#{@metadata[:contributor]}</tr></td>" unless @metadata[:contributor].nil?
      str_pre += "<tr.<th>リビジョン</th><td>#{@metadata[:revison]}</tr></td>" unless @metadata[:revison].nil?
      str_pre += "<tr><th>概要</th><td colspan='4'>#{@metadata[:description]}</td></tr>" unless @metadata[:description].nil?

      if str_pre.empty?
        str_pre
      else
        str + str_pre + "\n</table>\n</div>"
      end
    end

    def footnote
      return "" if @raf.inline_index[:footnote].nil?
      str = "<div id='raf-footnote'>"
      @raf.inline_index[:footnote].each_with_index do |f,i|
        str += "<a id='raf-footnote-#{i+1}' class='footnote' />"
        str += "<a href='#raf-footnote-#{i+1}-reverse' class='footnote-reverse'>*#{i+1}</a>"
        str += " #{f[:content].map{|c| c.apply}}<br />"
      end
      str += "</div>"
      str
    end

    def header
      str = <<EOL
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
   "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="en" xml:lang="#{@metadata[:language]}">
  <head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
EOL
      str += css
      str += <<EOL
  <title>#{@metadata[:subject]}</title>
  </head>
<body>
EOL
    end

    def header_title
      "<h1>#{@metadata[:subject]}</h1>\n"
    end

    def css
      str = <<EOL
<link href="screen.css" rel="stylesheet" type="text/css" media="screen" />
<link href="handheld.css" rel="stylesheet" type="text/css" media="handheld" />
<link href="print.css" rel="stylesheet" type="text/css" media="print" />
EOL
      str += %%<style type="text/css"><!--\n#{@css}\n--></style>\n% unless @css.nil?
      str
    end

    def footer
      str = "\n"
      str += "<div id='rights'>#{@metadata[:rights]}</div>\n" unless @metadata[:rights].nil?
      str += "</body>\n</html>"
      str
    end
  end
end
