module RuboCop::Git
# copy from https://github.com/thoughtbot/hound/blob/d2f3933/app/models/commit_file.rb
class CommitFile
  def initialize(file, commit)
    @file = file
    @commit = commit
  end

  def absolute_path
    @file.absolute_path
  end

  def filename
    @file.filename
  end

  def content
    @content ||= begin
      unless removed?
        @commit.file_content(filename)
      end
    end
  end

  def relevant_line?(line_number)
    modified_lines.detect do |modified_line|
      modified_line.line_number == line_number
    end
  end

  def removed?
    @file.status == 'removed'
  end

  def ruby?
    filename.match(/.*\.rb$/)
  end

  def modified_lines
    @modified_lines ||= patch.additions
  end

  def modified_line_at(line_number)
    modified_lines.detect do |modified_line|
      modified_line.line_number == line_number
    end
  end

  private

  def patch
    Patch.new(@file.patch)
  end
end
end
