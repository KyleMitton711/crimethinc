module ToolsHelper
  def link_to_tool tool:, type:
    link_to text_for_tool_link(type: type, tool: tool),
            [tool],
            class: classes_for_tool_link(type: type),
            target: link_target_for_tool(tool: tool)
  end

  def text_for_tool_link type:, tool:
    return "Browse All #{tool.capitalize} →" if type == :button

    tool.capitalize
  end

  def classes_for_tool_link type:
    'download button' if type == :button
  end

  def link_target_for_tool tool:
    '_blank' if tool == :music
  end
end
