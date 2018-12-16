require 'curses'

module Sijka
  class CursesInitializer
    class << self
      def call
        init_curses
      end

      def init_curses
        Curses.init_screen
        Curses.nonl
        Curses.noecho
        Curses.curs_set 0

        set_curses_trap
      end

      def set_curses_trap
        %w[HUP INT QUIT TERM].each do |sig|
          trap(sig) { |s| onsig(s) } if trap(sig, 'IGNORE') != 'IGNORE'
        end
      end

      def onsig(signal)
        Curses.close_screen
        exit signal
      end
    end
  end
end
