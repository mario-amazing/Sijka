require_relative 'sijka/smoke'
require_relative 'sijka/parser'
require_relative 'sijka/translator'

$LOAD_PATH.unshift(File.dirname(File.realpath(__FILE__)))

module Sijka
  class Sijka
    FILE_LIST = (Dir.entries("#{$LOAD_PATH.first}/characters") - %w[. ..]).freeze

    def initialize(argv, stdin)
      sijka_parser = SijkaParser.new(argv, stdin)
      @options = sijka_parser.parse_flags
      @message = sijka_parser.parse_message
    end

    def smoke
      if @options['list']
        puts 'Sijka files:', "\n", FILE_LIST
      else
        Smoke.new(@message, @options['sijkafile']).smoke
      end
    end
  end
end
