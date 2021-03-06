require "shrine"

case Rails.configuration.active_storage.service
when :cloudinary
  require "cloudinary"
  require "shrine/storage/cloudinary"

  Cloudinary.config(
    cloud_name: Rails.application.credentials.dig(:cloudinary, :cloud_name),
    api_key:    Rails.application.credentials.dig(:cloudinary, :api_key),
    api_secret: Rails.application.credentials.dig(:cloudinary, :api_secret)
  )

  Shrine.storages = {
    cache: Shrine::Storage::Cloudinary.new(prefix: "cache"),
    store: Shrine::Storage::Cloudinary.new,
  }
when :local
  require "shrine/storage/file_system"

  Shrine.storages = {
    cache: Shrine::Storage::FileSystem.new("public", prefix: "uploads/cache"),
    store: Shrine::Storage::FileSystem.new("public", prefix: "uploads"),
  }

when :test
  require "shrine/storage/memory"

  Shrine.storages = {
    cache: Shrine::Storage::Memory.new,
    store: Shrine::Storage::Memory.new,
  }
end

Shrine.plugin :activerecord
Shrine.plugin :cached_attachment_data
Shrine.plugin :restore_cached_data
Shrine.plugin :pretty_location
Shrine.plugin :derivatives, create_on_promote: true
