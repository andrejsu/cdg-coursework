class ImageUploader < Shrine
  ALLOWED_TYPES  = %w[image/jpeg image/png image/webp].freeze
  MAX_SIZE       = 10 * 1024 * 1024 # 10 MB
  MAX_DIMENSIONS = [5000, 5000].freeze # 5000x5000

  plugin :validation_helpers
  plugin :store_dimensions
  plugin :determine_mime_type

  Attacher.validate do
    validate_size 0..MAX_SIZE
    validate_max_dimensions MAX_DIMENSIONS if validate_mime_type ALLOWED_TYPES
  end

  Attacher.derivatives do |original|
    require 'image_processing/mini_magick'

    magick = ImageProcessing::MiniMagick.source(original)
    {
      square: magick.resize_to_fill!(1080, 1080),
      preview: magick.resize_to_fill!(300, 300)
    }
  end
end
