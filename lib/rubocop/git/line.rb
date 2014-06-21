module RuboCop::Git
# copy from https://github.com/thoughtbot/hound/blob/a6a8d3f/app/models/line.rb
class Line < Struct.new(:content, :line_number, :patch_position)
  def ==(other_line)
    content == other_line.content
  end
end
end
