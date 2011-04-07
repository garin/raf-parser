module Raf
 
  class Element
    def newline_to_br(str)
      str.gsub("\n", "<br />\n")
    end

    # @inline_parser.parse の配列を文字列に変換する
    def inline_parse_to_str(array)
      str = ""
      array.each do |obj|
        str += obj.apply
      end
      str
    end
  end
  
  # ----- Blocks
  class WhiteLine < Element
    def apply
      "\n"
    end
  end
  
  class PlainTextBlock < Element
    def apply
      @contents.map {|c| c.apply }
    end
  end
  
  class HeadLine < Element
    # @contents = [level, title, id, index]
    def apply
      return "" if @contents[0] == 1
      str = ""
      str += "<h#{@contents[0]} id='raf-head#{@contents[0]}-#{@contents[2]}'>"
      str += "<a id='#{@contents[1].to_code}'></a>"
      str += "#{@contents[3]}" unless @contents[0] == 1 or @contents[0] == 5 or @contents[0] == 6
      str += "#{@contents[1]}</h#{@contents[0]}>\n"
      str
    end
  end
  
  class Paragraph  < Element
    def apply
      "<p>#{@contents.map{|c| c.apply}}</p>\n"
    end
  end

  class Quote < Element
    def apply
      "<pre>#{@contents}</pre>\n"
    end
  end  

  class ItemList < Element
    def apply
      return "" if @contents.empty?
      type = :dummy
      str = "<ul>\n"
      @contents.each do |item|
        type_pre = type
        case item
        when :INDENT
          type = :indent          
          str += "\n<ul>\n"
        when :DEDENT
          type = :dedent          
          str += "</li>\n" if type_pre == :item          
          str += "</ul>\n</li>\n"
        else
          type = :item          
          str += "</li>\n" if type_pre == :item
          str += "<li>#{item.apply}"
        end
      end
      str += "\n</li>"  if type == :item
      str += "\n</ul>\n"
      str
    end
  end

  class NumList < Element
    def apply
      str = "<ol>\n"
      @contents.map do |item|
        if item == :INDENT
          str += "<ol>\n"
        elsif item == :DEDENT
          str += "</ol>\n"
        else
          str += "<li>#{item.apply}</li>\n"
        end
      end
      str += "</ol>\n"
      str 
    end
  end

  class Desc < Element
    # @contents = [title, lines]
    def apply
      str = "<dl id='#{@contents[0].to_code}'>\n<dt>#{@contents[0]}</dt>\n"
      str += "<dd>#{inline_parse_to_str(@contents[1])}</dd>\n" unless inline_parse_to_str(@contents[1]).empty?
      str += "</dl>"
      str
    end
  end

  class Table < Element
    def apply
      str = "<table>"
      @contents.each do |line|
        str += "\n<tr>"
        line.each do |item|
          if item =~ /^\s*\*/
            str += "<th>#{item.sub(/^\s*\*/, "").sub(/\*\s*$/,"")}</th>"
          else
            str += "<td>#{item}</td>"  
          end
        end
        str += "\n</tr>"
      end
      str += "\n</table>"
      str
    end
  end
  # --- Blocks end
  
  # --- Inlines 
  class Label < Element
    # @contents = [label, title]
    def apply
      "<a href='##{@contents[0]}' id='#{@contents[0]}'>#{@contents[1]}</a>"
    end
  end
  
  class Reference < Element
    def apply
      "<a href='#{@contents[1]}' title='#{@contents[1]}'>#{@contents[0]}</a>"
    end
  end


  class Plain < Element
    def apply
      "#{newline_to_br(@contents.join(""))}"
    end
  end
  
  class Emphasis       < Element
    def apply
      "<em>#{@contents.map{|c| c.apply}}</em>"
    end
  end
  class Italic       < Element
    def apply
      "<i>#{@contents.map{|c| c.apply}}</i>"
    end
  end
  class Strike       < Element
    def apply
      "<s>#{@contents.map{|c| c.apply}}</s>"
    end
  end

  class Verb       < Element
    def apply
      "#{@contents}"
    end
  end

  class Manuedo       < Element
    def apply
      "<span class='manuedo'>/#{@contents.map{|c| c.apply}}/</span>"
    end
  end
  class Ruby       < Element
    def apply
      "<ruby><rb>#{@contents[0]}</rb><rp>(</rp><rt>#{@contents[1]}</rt><rp>)</rp></ruby>"
    end
  end
  
  class Footnote       < Element
    def apply
      "<a href='#raf-footnote-#{@contents[1]}' name='raf-footnote-#{@contents[1]}-reverse' title='#{@contents[0].map {|c| c.apply}}'><sup><small>*#{@contents[1]}</small></sup></a>"
    end
  end  

  class Image       < Element
    def apply
      "<img src='#{@contents}' />"
    end
  end  
end
