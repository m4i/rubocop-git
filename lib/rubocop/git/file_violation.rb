module RuboCop::Git
# copy from https://github.com/thoughtbot/hound/blob/a6a8d3f/app/models/file_violation.rb
class FileViolation < Struct.new(:filename, :offenses)
end
end
