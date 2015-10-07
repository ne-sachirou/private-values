require 'fileutils'
require 'optparse'
require 'yaml'

module PrivateValues
  class CLI
    def initialize
      config_file = "#{ENV['HOME']}/private-values.rc"
      @config = File.exist?(config_file) ? YAML.load_file(config_file) : {}
      @config['values-dir'] ||= '~/.private-values'
      @config['values-dir']   = File.expand_path @config['values-dir']
      @config['password']   ||= nil
      case ARGV[0]
      when 'new'  then cmd_new
      when 'set'  then cmd_set
      when 'rm'   then cmd_rm
      when 'get'  then cmd_get
      when 'path' then cmd_path
      else             cmd_else
      end
    end

    private

    def cmd_new
      # open('/tmp/private-values.log', 'w'){}
      project = ARGV[1]
      validate_project_name project
      FileUtils.mkdir_p project_dir_name project
      File.new(values_file_name(project), 'w'){|f| f.write({}.to_yaml) }
    end

    def cmd_rm
      # open('/tmp/private-values.log', 'w'){}
      project = ARGV[1]
      FileUtils.rm_rf project_dir_name(project), secure: true
    end

    def cmd_set
      # open('/tmp/private-values.log', 'w'){}
      project, key = ARGV[1].split '.', 2
      value = ARGV[2]
      validate_project_name project
      value = unify_str_value value
      values = YAML.load_file(values_file_name project) || {}
      values[key] = value
      File.open(values_file_name(project), 'w:utf-8'){|f| f.write values.to_yaml }
    end

    def cmd_get
      # open('/tmp/private-values.log', 'w'){}
      project, key = ARGV[1].split '.', 2
      values = YAML.load_file(values_file_name project) || {}
      $stdout.puts values[key]
    end

    def cmd_path
      # open('/tmp/private-values.log', 'w'){}
      project = ARGV[1]
      $stdout.puts project_dir_name project
    end

    def cmd_else
      puts <<HELP
private-values

Commands
--
new PROJECT          \tCreate new private values.
rm PROJECT           \tRemove private values.
set PROJECT.KEY VALUE\tSet a private value.
get PROJECT.KEY      \tGet the private value.
path PROJECT         \tPath to the private files.

~/private-values.rc
--
values-dir: ~/.private-values
password: PASSWORD
HELP
    end

    def validate_project_name project
      throw 'The project name shold only contain [-A-Za-z0-9_.]' if project !~ /\A[-A-Za-z0-9_.]+\z/
    end

    def project_dir_name project
      "#{@config['values-dir']}/#{project}"
    end

    def values_file_name project
      "#{project_dir_name project}/values.yml"
    end

    def unify_str_value str
      return Integer(str) rescue nil
      return Float(str) rescue nil
      str
    end
  end
end
