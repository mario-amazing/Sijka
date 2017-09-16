require 'terminfo'

module Sijka
  class Smoke
    SLEEP_TIME = 0.02

    def initialize(name, file_name)
      set_standarted_img file_name
      @movement_range = TermInfo.screen_size[1] - @img_length

      message = Translator.new.smoken_with_locale(file_name)
      @message_with_name = name.to_s.empty? ? "#{message}!" : "#{message}, #{name}!"
    end

    def smoke
      right_move
      reverse_img
      left_move
      puts @message_with_name
      sleep(1.3)
      system 'clear'
    end

    private

    def right_move
      @movement_range.times do
        system 'clear'
        puts @img
        sleep(SLEEP_TIME)
        @img.map! { |line| line.insert(0, ' ') }
      end
    end

    def set_standarted_img(file_name)
      file_name = !file_name.to_s.empty? && Sijka::FILE_LIST.include?(file_name) ? file_name : 'sijka'
      file_path = "#{$LOAD_PATH.first}/characters/#{file_name.downcase}"
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
        system 'clear'
        puts @img
        sleep(SLEEP_TIME)
        @img.map! { |line| line[1..-1] }
      end
    end
  end
end
