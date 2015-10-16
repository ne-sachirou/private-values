require 'optparse'
require 'yaml'
require_relative 'project'

module PrivateValues
  class CLI
    def initialize
      config_file = "#{ENV['HOME']}/private-values.rc"
      @config = File.exist?(config_file) ? YAML.load_file(config_file) : {}
      Project.config values_dir: @config['values-dir']
      case ARGV[0]
      when 'new'      then cmd_new
      when 'set'      then cmd_set
      when 'rm'       then cmd_rm
      when 'projects' then cmd_projects
      when 'keys'     then cmd_keys
      when 'get'      then cmd_get
      when 'path'     then cmd_path
      else                 cmd_else
      end
    end

    private

    def cmd_new
      project_name = ARGV[1]
      Project.new(project_name).create
    end

    def cmd_rm
      project_name = ARGV[1]
      Project.new(project_name).destroy
    end

    def cmd_projects
      $stdout.puts Project.projects
    end

    def cmd_keys
      project_name = ARGV[1]
      project = Project.new project_name
      the_project_must_exist project
      $stdout.puts project.keys
    end

    def cmd_set
      project_name, key = ARGV[1].split '.', 2
      value = ARGV[2]
      project = Project.new project_name
      the_project_must_exist project
      project[key] = value
    end

    def cmd_get
      project_name, key = ARGV[1].split '.', 2
      project = Project.new project_name
      the_project_must_exist project
      $stdout.print project[key]

    end

    def cmd_path
      project_name = ARGV[1]
      project = Project.new project_name
      the_project_must_exist project
      $stdout.print project.path
    end

    def cmd_else
      puts File.read "#{__dir__}/../../src/Help.txt", mode: 'r:utf-8'
    end

    def the_project_must_exist project
      unless project.exist?
        throw %{The project "#{project.name}" isn\'t exist.
Run `private-values new #{project.name}`.}
      end
    end
  end
end
