require_relative 'sijka/smoke'
require_relative 'sijka/parser'
require_relative 'sijka/translator'
require_relative 'sijka/curses_initializer'

$LOAD_PATH.unshift(__dir__)

module Sijka
  class Sijka
    FILE_LIST = (Dir.entries("#{$LOAD_PATH.first}/characters") - %w[. ..]).freeze
    attr_reader :options, :message

    def initialize(argv)
      sijka_parser = SijkaParser.new(argv)
      @options = sijka_parser.parse_flags
      @message = sijka_parser.parse_message
    end

    def smoke
      if options['list']
        puts 'Sijka files:', "\n", FILE_LIST
      else
        Smoke.new(message, options['sijkafile']).smoke
      end
    end
  end
end
