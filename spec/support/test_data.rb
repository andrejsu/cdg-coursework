module TestData
  module_function

  def image_data
    uploaded_image = uploaded_image('spec/fixtures/pixel.png')

    attacher = Shrine::Attacher.new
    attacher.set(uploaded_image)

    attacher.set_derivatives(
      square: uploaded_image,
      preview: uploaded_image
    )

    attacher.column_data
  end

  def uploaded_image(path, metadata = {})
    file = File.open(path, binmode: true)

    uploaded_file = Shrine.upload(file, :cache, metadata: false)
    uploaded_file.metadata.merge!(
      'size' => File.size(file.path),
      'mime_type' => 'image/png',
      'filename' => File.basename(file.path),
      'width' => 1,
      'height' => 1
    ).merge!(metadata)

    uploaded_file
  end
end
