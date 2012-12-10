# Copyright (C) garin <garin54@gmail.com> 2011
# See the included file COPYING for details.
# -*- encoding: utf-8 -*-
module ParserUtility
  def add_children_to_element(obj, *val)
    obj.add = *val
  end

  def mark_to_level(mark_str)
     mark2level_list = {
      "=" => 1,
      "==" => 2,
      "===" => 3,
      "====" => 4,
      "+" => 5,
      "++" => 6
    }
    mark2level_list[mark_str] or
      raise ArgumentError, "#{mark_str} is irregular for Headline mark."
  end
end
