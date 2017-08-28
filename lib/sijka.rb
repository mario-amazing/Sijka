require_relative 'sijka/smoke'
require_relative 'sijka/parser'
require_relative 'sijka/translator'

module Sijka
  class Sijka
    def initialize(argv, stdin)
      sijka_parser = SijkaParser.new(argv, stdin)
      @options = sijka_parser.parse_flags
      @message = sijka_parser.parse_message
    end

    def smoke
      if @options['list']
        puts 'Sijka files:', Smoke::FILE_LIST
      else
        Smoke.new(@message, @options['sijkafile']).smoke
      end
    end
  end
end
