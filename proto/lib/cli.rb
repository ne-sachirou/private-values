require 'optparse'
require 'yaml'

module PrivateValues
  class CLI
    def initialize
      config_file = "#{ENV['HOME']}/private-values.rc"
      @config = File.exist?(config_file) ? YAML.load_file(config_file) : {}
      @config['values-dir'] ||= '~/.private-values'
      @config['password']   ||= nil
      case ARGV[0]
      when 'new'  then cmd_new
      when 'set'  then cmd_set
      when 'get'  then cmd_get
      when 'path' then cmd_path
      else             cmd_else
      end
    end

    private

    def cmd_new
    end

    def cmd_set
    end

    def cmd_get
    end

    def cmd_path
    end

    def cmd_else
      puts <<HELP
private-values

Commands
--
new PROJECT\t
set PROJECT.KEY VALUE\t
get PROJECT.KEY\t

~/private-values.rc
--

HELP
    end
  end
end
