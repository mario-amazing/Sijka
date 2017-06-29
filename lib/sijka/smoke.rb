require 'terminfo'
require 'I18n' #TODO locales

module Sijka
  class Smoke
    SLEEP_TIME = 0.02
    FILE_LIST = [ 'base' ] #TODO added method when add other screens

    def initialize(message, file_name)
      file_name =  !file_name.to_s.empty? && FILE_LIST.include?(file_name) ? file_name : 'base'
      @message = message.to_s.empty? ? 'All was smoking!' : "All was smoking, #{message}!"
      file_path = "#{File.dirname(__FILE__)}/../characters/#{file_name.downcase}.txt"
      @img = File.open(file_path) { |file| file.read.split("\n") }
      @movement_range = TermInfo.screen_size[1] - @img.first.length
    end

    def smoke
      right_move
      reverse_img
      left_move
      puts @message
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
