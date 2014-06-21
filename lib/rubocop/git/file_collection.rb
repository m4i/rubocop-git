module RuboCop::Git
# copy from https://github.com/thoughtbot/hound/blob/a6a8d3f/app/models/file_collection.rb
class FileCollection
  IGNORED_FILES = ['db/schema.rb']

  attr_reader :files

  def initialize(files)
    @files = files
  end

  def relevant_files
    files.reject do |file|
      file.removed? || !file.ruby? || IGNORED_FILES.include?(file.filename)
    end
  end
end
end
