require 'fileutils'
require 'yaml'

module PrivateValues
  class Project
    class << self
      def config values_dir: nil
        @@values_dir = File.expand_path(values_dir || '~/.private-values')
      end

      def projects
        Dir["#{@@values_dir}/*"].collect{|d| File.basename d }
      end
    end

    attr_reader :name

    def initialize name
      throw 'The project name shold only contain [-A-Za-z0-9_]' if name !~ /\A[-A-Za-z0-9_]+\z/
      @name = name
    end

    def path
      "#{@@values_dir}/#{@name}"
    end

    def exist?
      Dir.exist? path
    end

    def create
      FileUtils.mkdir_p path
      save_values({})
    end

    def destroy
      FileUtils.rm_rf path, secure: true
    end

    def keys
      load_values.keys
    end

    def [] key
      load_values[key]
    end

    def []= key, value
      values = load_values
      values[key] = value
      save_values values
    end

    private

    def load_values
      data = File.read "#{path}/values.yml", mode: 'rb'
      YAML.load(data) || {}
    end

    def save_values values
      data = values.to_yaml
      File.open("#{path}/values.yml", 'wb'){|f| f.write data }
    end
  end
end
