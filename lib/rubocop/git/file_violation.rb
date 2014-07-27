module RuboCop::Git
# ref. https://github.com/thoughtbot/hound/blob/d2f3933/app/models/file_violation.rb
class FileViolation < Struct.new(:filename, :offenses)
end
end
