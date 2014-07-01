module RuboCop::Git
# ref. https://github.com/thoughtbot/hound/blob/be2dd34/app/models/style_guide.rb
class StyleGuide
  def initialize(rubocop_options, config_path, override_config_content = nil)
    @rubocop_options = rubocop_options
    @config_path = config_path
    @override_config_content = override_config_content
  end

  def violations(file)
    if ignored_file?(file)
      []
    else
      parsed_source = parse_source(file)
      team = Rubocop::Cop::Team.new(
               Rubocop::Cop::Cop.all, configuration, @rubocop_options)
      commissioner = Rubocop::Cop::Commissioner.new(team.cops, [])
      commissioner.investigate(parsed_source)
    end
  end

  private

  def ignored_file?(file)
    !file.ruby? ||
      file.removed? ||
        configuration.file_to_exclude?(file.filename)
  end

  def parse_source(file)
    Rubocop::SourceParser.parse(file.contents, file.filename)
  end

  def configuration
    config = Rubocop::ConfigLoader.configuration_from_file(@config_path)

    if override_config
      config = Rubocop::Config.new(
        Rubocop::ConfigLoader.merge(config, override_config),
        ''
      )
      config.make_excludes_absolute
    end

    config
  end

  def override_config
    if @override_config_content
      Rubocop::Config.new(YAML.load(@override_config_content))
    end
  end
end
end
