require 'optparse'

module Sijka
  class SijkaParser
    def initialize(argv, stdin)
      @argv = argv
      @stdin = stdin
    end

    def parse_flags
      options = {}
      OptionParser.new do |opts|
        opts.banner = 'Usage: sijka [name] [-h] [-f sijkafile] [-l]'
        opts.on('-l', 'List available sijka files') do |_|
          options['list'] = true
        end
        opts.on('-f SIJKAFILE', 'Specify a sijka file') do |sijkafile|
          options['sijkafile'] = sijkafile
        end
      end.parse!
      options
    end

    def parse_message
      if @argv.any?
        @argv.join(' ')
      else
        @stdin.tty? ? '' : @argv.read.chomp
      end
    end
  end
end
