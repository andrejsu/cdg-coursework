class ImageUploader < Shrine
  ALLOWED_TYPES  = %w[image/jpeg image/png image/webp].freeze
  MAX_SIZE       = 10 * 1024 * 1024 # 10 MB
  MAX_DIMENSIONS = [5000, 5000].freeze # 5000x5000

  plugin :default_url
  plugin :validation_helpers
  plugin :store_dimensions

  # File validations (requires `validation_helpers` plugin)
  Attacher.validate do
    validate_size 0..MAX_SIZE

    validate_max_dimensions MAX_DIMENSIONS if validate_mime_type ALLOWED_TYPES
  end

  Attacher.default_url do |**options|
    '/placeholders/missing.jpg'
  end
end
