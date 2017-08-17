module RuboCop::Git
# ref. https://github.com/thoughtbot/hound/blob/d2f3933/app/models/style_checker.rb
class StyleChecker
  def initialize(modified_files,
                 rubocop_options,
                 config_file,
                 custom_config = nil)
    @modified_files = modified_files
    @rubocop_options = rubocop_options
    @config_file = config_file
    @custom_config = custom_config
  end

  def violations
    file_violations = @modified_files.map do |modified_file|
      FileViolation.new(modified_file.absolute_path, offenses(modified_file))
    end

    file_violations.select do |file_violation|
      file_violation.offenses.any?
    end
  end

  private

  def offenses(modified_file)
    violations = style_guide.violations(modified_file)
    violations_on_changed_lines(modified_file, violations)
  end

  def violations_on_changed_lines(modified_file, violations)
    violations.select do |violation|
      modified_file.relevant_line?(violation.line)
    end
  end

  def style_guide
    @style_guide ||= StyleGuide.new(@rubocop_options,
                                    @config_file,
                                    @custom_config)
  end
end
end
