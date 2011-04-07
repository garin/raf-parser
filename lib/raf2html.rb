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
      @quiet = options[:quiet]

      @raf = BlockParser.new
      @info = setup_info
      @nodes = @raf.parse src.map {|s| CGI.escapeHTML(s) }
    end

    def setup_info
      info = @raf.info
      info[:language] = @language if info[:language].nil?
      info
    end

    def to_html
      html = ""
      html += header unless @quiet
      html += header_title
      html += metadata
      html += index if @index
      html += body
      html += footnote
      html += footer unless @quiet
      html
    end

    def body
      @nodes.map do |node| node.apply end.to_s
    end


    def index
      return "" if @raf.index[:head].nil?
      str = "<div id='raf-index'>"
      level_pre = 1
      @raf.index[:head].each_with_index do |h,i|
        next if h[:level] == 1 or h[:level] == 6

        if h[:level] == 5
          str += '<br />'
          str += "<a href='#raf-head#{h[:level]}-#{i+1}' style='padding-left: 1em'>#{h[:title]}</a>\n"
        else
          str += index_terminate(h[:level], level_pre)
          str += "<li><a href='#raf-head#{h[:level]}-#{i+1}'>#{h[:index]} #{h[:title]}</a>\n"
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
      str_pre += "<tr><th>著者</th><td colspan='3'>#{@info[:creator]}</td></tr>" unless @info[:creator].nil?

      unless @info[:date].nil? or @info[:update].nil?
        str_pre += "<tr>"
        str_pre += "<th>作成日</th><td>#{@info[:date]}</td>"  unless @info[:date].nil?
        str_pre += "<th>更新日</th><td>#{@info[:update]}</td>" unless @info[:update].nil?
        str_pre += "</tr>"
      end

      unless @info[:publisher].nil? or @info[:version].nil?
        str_pre += "<tr>"
        str_pre += "<th>発行</th><td>#{@info[:publisher]}</td>" unless @info[:publisher].nil?
        str_pre += "<th>バージョン</th><td>#{@info[:version]}</td>" unless @info[:version].nil?
        str_pre += "</tr>"
      end

      unless @info[:contributor].nil? or @info[:revison].nil?
        str_pre += "<tr>"
        str_pre += "<th>寄稿者</th>#{@info[:contributor]}</td>" unless @info[:contributor].nil?
        str_pre += "<th>リビジョン</th><td>#{@info[:revison]}</td>" unless @info[:revison].nil?
        str_pre += "</tr>"
      end

      str_pre += "<tr><th>概要</th><td colspan='4'>#{@info[:description]}</td></tr>" unless @info[:description].nil?

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
        str += "<a id='raf-footnote-#{i+1}' />"
        str += "<a href='#raf-footnote-#{i+1}-reverse'>*#{i+1}</a>"
        str += " #{f[:content].map{|c| c.apply}}<br />"
      end
      str += "</div>"
      str
    end

    def header
      str = <<EOL
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
   "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="en" xml:lang="#{@info[:language]}">
  <head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
EOL
      str += css
      str += <<EOL
  <title>#{@info[:subject]}</title>
  </head>
<body>
EOL
    end

    def header_title
      "<h1>#{@info[:subject]}</h1>\n"
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
      str += "<div id='rights'>#{@info[:rights]}</div>\n" unless @info[:rights].nil?
      str += "</body>\n</html>"
      str
    end
  end
end

