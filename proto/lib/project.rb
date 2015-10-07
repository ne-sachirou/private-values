require 'fileutils'
require 'yaml'

module PrivateValues
  class Project
    def initialize name, config
      throw 'The project name shold only contain [-A-Za-z0-9_]' if name !~ /\A[-A-Za-z0-9_]+\z/
      @name   = name
      @config = config
    end

    def create
      FileUtils.mkdir_p path
      File.open(values_file_name, 'w'){|f| f.write({}.to_yaml) }
    end

    def destroy
      FileUtils.rm_rf path, secure: true
    end

    def [] key
      (YAML.load_file(values_file_name) || {})[key]
    end

    def []= key, value
      value = unify_str_value value
      values = YAML.load_file(values_file_name) || {}
      values[key] = value
      File.open(values_file_name, 'w:utf-8'){|f| f.write values.to_yaml }
    end

    def path
      "#{@config['values-dir']}/#{@name}"
    end

    private

    def values_file_name
      "#{path}/values.yml"
    end

    def unify_str_value str
      return Integer(str) rescue nil
      return Float(str) rescue nil
      str
    end
  end
end
