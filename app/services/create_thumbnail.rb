require 'vips'

class CreateThumbnail < CreateImageDerivative
  private
    def source_width
      source_image.x_size
    end

    def source_height
      source_image.y_size
    end

    def aspect_ratio
      source_width.to_f / source_height.to_f
    end

    def size
      @size ||= calculate_size
    end

    def calculate_size
      if options[:height] && options[:height] < source_height
        width = (options[:height] * aspect_ratio).round
        [width, options[:height]]
      elsif options[:width] && options[:width] < source_width
        height = (options[:width] / aspect_ratio).round
        [options[:width], height]
      else
        [source_width, source_height]
      end
    end

    def quality
      options[:quality] || 60
    end

    def create_derivative!
      system(thumbnail_command)
    end

    def vips_command_size
      "-s #{size.join('x')}"
    end

    def vips_command_source
      Shellwords.escape(source_filepath)
    end

    def vips_command_target
      "-o #{Shellwords.escape(target_filepath)}#{output_options}"
    end

    def jpg?
      (File.extname(target_filepath) =~ /^[.]jpe?g$/).present?
    end

    def output_options
      if jpg?
        "[Q=#{quality}]"
      else
        ""
      end
    end

    def vips_command_array
      [
        Rails.configuration.settings.vips_thumbnail_command,
        vips_command_size,
        vips_command_target,
        vips_command_source,
      ]
    end

    def thumbnail_command
      puts vips_command_array.join(' ')
      vips_command_array.join(' ')
    end

end
