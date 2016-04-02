module RuboCop::Git
# copy from https://github.com/thoughtbot/hound/blob/d2f3933/app/models/patch.rb
class Patch
  RANGE_INFORMATION_LINE = /^@@ .+\+(?<line_number>\d+),/
  MODIFIED_LINE = /^\+(?!\+|\+)/
  NOT_REMOVED_LINE = /^[^-]/
  PATCH_INFO_LINE = /\+([0-9,]+)/

  def initialize(body)
    @body = body || ''
    @changes = []
  end

  def additions
    line_number = 0

    lines.each_with_index.inject(@changes) do |additions, (content, patch_position)|
      case content
      when RANGE_INFORMATION_LINE
        line_number = Regexp.last_match[:line_number].to_i
      when MODIFIED_LINE
        additions << Line.new(content, line_number, patch_position)
        line_number += 1
      when NOT_REMOVED_LINE
        line_number += 1
      end

      additions
    end
  end

  # maps out additions line numbers to indicate start and end of code changes
  # [[5,7], [11,11]] indicates changes from line 5, 6, 7 and then
  # another one at 11
  def additions_map
    if @changes.empty?
      self.additions
    end

    map = []
    starting_line = ending_line = 0

    @changes.each do |addition|
      if starting_line == 0
        starting_line = ending_line = addition.line_number
      elsif addition.line_number == ( ending_line + 1 )
        ending_line = addition.line_number
      else # this row is not part of the last rows "group"
        map.push([starting_line, ending_line])
        starting_line = ending_line = addition.line_number
      end
    end
    map.push([starting_line, ending_line])
    map
  end

  private

  def lines
    @body.lines
  end
end
end
