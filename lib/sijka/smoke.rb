require 'terminfo'

module Sijka
  class Smoke
    MOVE_SLEEP_TIME = 0.02
    SLEEP_TIME_IN_THE_END = 1.3
    DEFAULT_IMG_FILE = 'sijka'.freeze

    attr_reader :img_file_name

    def initialize(smoker_name, file_name)
      @img_file_name = validated_img_file_name(file_name)
      load_standarted_img
      @movement_range = TermInfo.screen_size[1] - @img_length

      message = Translator.new.smoken_with_locale(img_file_name)
      @message_with_name ||= smoker_name.to_s.empty? ? "#{message}!" : "#{message}, #{smoker_name}!"
    end

    def smoke
      right_move
      reverse_img
      left_move
      puts @message_with_name
      sleep(SLEEP_TIME_IN_THE_END)
      clear_terminal
    end

    private

    def clear_terminal
      Gem.win_platform? ? (system 'cls') : (system 'clear')
    end

    def right_move
      @movement_range.times do
        clear_terminal
        puts @img
        sleep(MOVE_SLEEP_TIME)
        @img.map! { |line| line.insert(0, ' ') }
      end
    end

    def load_standarted_img
      file_path = "#{$LOAD_PATH.first}/characters/#{img_file_name}"
      @img = File.open(file_path) { |file| file.read.split("\n") }

      @img_length = @img.max_by(&:length).length
      @img.map { |line| line << ' ' * (@img_length - line.length) }
    end

    def reverse_img
      @img.map! do |line|
        line[0..@movement_range - 1] + line[@movement_range..-1].reverse
      end
    end

    def left_move
      @movement_range.times do
        clear_terminal
        puts @img
        sleep(MOVE_SLEEP_TIME)
        @img.map! { |line| line[1..-1] }
      end
    end

    def validated_img_file_name(file_name)
      if !file_name.to_s.empty? && Sijka::FILE_LIST.include?(file_name)
        file_name.downcase
      else
        DEFAULT_IMG_FILE
      end
    end
  end
end
