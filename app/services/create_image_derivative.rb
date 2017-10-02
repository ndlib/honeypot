require 'vips'

class CreateImageDerivative
  attr_reader :source_filepath, :target_filepath, :options

  def self.call(source_filepath, target_filepath, options = {})
    new(source_filepath, target_filepath, options).convert!
  end

  def initialize(source_filepath, target_filepath, options = {})
    @source_filepath = source_filepath
    @target_filepath = target_filepath
    @options = options
  end

  def convert!
    verify_source_image!
    create_target_directory!
    create_derivative!
  end

  private
    def verify_source_image!
      if !File.exist?(source_filepath)
        raise ArgumentError, "source file not found: #{source_filepath}"
      end
    end

    def create_derivative!
      raise NotImplementedError
    end

    def create_target_directory!
      dirname = File.dirname(target_filepath)
      unless File.directory?(dirname)
        FileUtils.mkdir_p(dirname)
      end
    end

    def source_image
      @source_image ||= Vips::Image.new_from_file(source_filepath)
    end
end
