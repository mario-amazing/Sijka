require 'optparse'

module Sijka
  class SijkaParser
    def initialize(argv)
      @argv = argv
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
        opts.on('-r', 'Random file') do |_|
          options['sijkafile'] = Sijka::FILE_LIST.sample
        end
      end.parse!
      options
    end

    def parse_message
      @argv.any? ? @argv.join(' ') : ''
    end
  end
end
