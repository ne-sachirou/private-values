require 'optparse'
require 'yaml'
require_relative 'project'

module PrivateValues
  class CLI
    def initialize
      config_file = "#{ENV['HOME']}/private-values.rc"
      @config = File.exist?(config_file) ? YAML.load_file(config_file) : {}
      Project.config values_dir: @config['values-dir'], password: @config['password']
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
      project_name = ARGV[1]
      Project.new(project_name).create
    end

    def cmd_rm
      # open('/tmp/private-values.log', 'w'){}
      project_name = ARGV[1]
      Project.new(project_name).destroy
    end

    def cmd_set
      # open('/tmp/private-values.log', 'w'){}
      project_name, key = ARGV[1].split '.', 2
      value = ARGV[2]
      project = Project.new project_name
      the_project_must_exist project
      project[key] = value
    end

    def cmd_get
      # open('/tmp/private-values.log', 'w'){}
      project_name, key = ARGV[1].split '.', 2
      project = Project.new project_name
      the_project_must_exist project
      $stdout.puts project[key]

    end

    def cmd_path
      # open('/tmp/private-values.log', 'w'){}
      project_name = ARGV[1]
      project = Project.new project_name
      the_project_must_exist project
      $stdout.puts project.path
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

    def the_project_must_exist project
      unless project.exist?
        throw 'The project "someProject" isn\'t exist.
Run `private-values new someProject`.'
      end
    end
  end
end
