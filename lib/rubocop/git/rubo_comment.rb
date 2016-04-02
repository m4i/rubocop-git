module RuboCop::Git
class RuboComment
  RUBOCOP_DISABLE = "# rubocop:disable all\n"
  RUBOCOP_ENABLE = "# rubocop:enable all\n"
  WHITE_SPACE = /^\s*/

  def initialize(files)
    @edit_map = {}
    @files = files
  end

  # adds rubocop enable and disabled comments to files
  # making sure only edited lines are processed by rubocop
  def add_comments
    @files.each do |file|
      patch_info = Patch.new(file.patch).additions_map
      temp_file = Tempfile.new('temp')

      line_count = edited_line_count = current_patch = 0
      in_patch = false
      edit_locations = []

      begin
        File.open(file.filename, "r").each_line do |line|
          line_count += 1
          edited_line_count += 1

          if line_count == patch_info[current_patch].first
            temp_file.puts generate_spaces(line) + RUBOCOP_ENABLE
            in_patch = true
            edit_locations.push edited_line_count
            edited_line_count += 1

          elsif in_patch && patch_info[current_patch].last + 1 == line_count
            temp_file.puts generate_spaces(line) + RUBOCOP_DISABLE
            in_patch = false
            edit_locations.push edited_line_count
            edited_line_count += 1
            current_patch += 1 unless (current_patch + 1) >= patch_info.size

          elsif line_count == 1 #adds disable at top of file
            temp_file.puts generate_spaces(line) + RUBOCOP_DISABLE
            edit_locations.push edited_line_count
            edited_line_count += 1

          end
          temp_file.puts line
        end

        temp_file.close
        FileUtils.mv(temp_file.path, file.filename)
        @edit_map[file.filename] = edit_locations
      ensure
        temp_file.close
        temp_file.unlink
      end
    end
  end

  # removes all added comments that where added from add_comments
  def remove_comments
    @files.each do |file|
      temp_file = Tempfile.new('temp')
      line_count = 0

      begin
        File.open(file.filename, "r").each_line do |line|
          line_count += 1
          temp_file.puts line unless @edit_map[file.filename].find_index line_count
        end
        
        temp_file.close
        FileUtils.mv(temp_file.path, file.filename)
      ensure
        temp_file.close
        temp_file.unlink
      end
    end
  end

  private

  # generates whitespaces to make en/disable comments match line indent
  # preventing rubocop errors
  def generate_spaces(line)
    whitespaces = ""
    WHITE_SPACE.match(line).to_s.split('').size.times { whitespaces << " " }
    whitespaces
  end

end
end
