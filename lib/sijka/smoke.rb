module Sijka
  class Smoke
    MOVE_SLEEP_TIME = 0.025
    SLEEP_TIME_IN_THE_END = 1.5
    DEFAULT_IMG_FILE = 'sijka'.freeze

    attr_reader :img_file_name, :smoker_name

    def initialize(smoker_name, file_name)
      @smoker_name = smoker_name
      @img_file_name = validated_img_file_name(file_name&.downcase)
      load_standarted_img
      CursesInitializer.call
      @movement_range = Curses.cols - @img_length
    end

    def smoke
      right_move
      reverse_img
      left_move
      write_end_message
    end

    private

    def clear_terminal
      Curses.refresh
      Curses.clear
    end

    def place_string(y_pos:, x_pos:, line:)
      Curses.setpos(y_pos, x_pos)
      Curses.addstr(line)
    end

    def draw_image(start_position:)
      @img.each_with_index { |line, y_position| place_string(y_pos: y_position, x_pos: start_position, line: line) }
    end

    def right_move
      @movement_range.times do |i|
        draw_image(start_position: i)
        sleep(MOVE_SLEEP_TIME)
        clear_terminal
      end
    end

    def left_move
      @movement_range.times do |i|
        draw_image(start_position: @movement_range - i)
        sleep(MOVE_SLEEP_TIME)
        clear_terminal
      end
    end

    def reverse_img
      @img.map!(&:reverse)
    end

    def message_with_name
      message = Translator.new.smoken_with_locale(img_file_name)
      smoker_name.to_s.empty? ? "#{message}!" : "#{message}, #{smoker_name}!"
    end

    def write_end_message
      place_string(y_pos: 0, x_pos: 0, line: message_with_name)
      clear_terminal
      sleep(SLEEP_TIME_IN_THE_END)
    end

    def load_standarted_img
      file_path = "#{$LOAD_PATH.first}/characters/#{img_file_name}"
      @img = File.open(file_path) { |file| file.read.split("\n") }

      @img_length = @img.max_by(&:length).length
      @img.map { |line| line << ' ' * (@img_length - line.length) }
    end

    def validated_img_file_name(file_name)
      file_name && Sijka::FILE_LIST.include?(file_name) ? file_name : DEFAULT_IMG_FILE
    end
  end
end
