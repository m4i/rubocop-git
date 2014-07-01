module RuboCop::Git
# ref. https://github.com/thoughtbot/hound/blob/be2dd34/app/models/file_violation.rb
class FileViolation < Struct.new(:filename, :offenses)
end
end
