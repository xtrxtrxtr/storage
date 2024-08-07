# frozen_string_literal: true

# Simple image uploader
class SimpleImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  storage :file
  process :auto_orient

  version :hd, if: :raster_image? do
    resize_to_fit(1920, 1920)
  end

  version :large, from_version: :hd, if: :raster_image? do
    resize_to_fit(1280, 1280)
  end

  version :medium, from_version: :large, if: :raster_image? do
    resize_to_fit(640, 640)
  end

  version :small, from_version: :medium, if: :raster_image? do
    resize_to_fit(320, 320)
  end

  version :preview, from_version: :small, if: :raster_image? do
    resize_to_fit(160, 160)
  end

  version :tiny, from_version: :preview, if: :raster_image? do
    resize_to_fit(48, 48)
  end

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{path_slug}"
  end

  def auto_orient
    return unless raster?

    manipulate! do |image|
      image.tap(&:auto_orient)
    end
  end

  def extension_allowlist
    [/jpe?g/, 'png', /svgz?/]
  end

  # Text for image alt attribute
  #
  # @param [String] default
  # @return [String]
  def alt_text(default = '')
    method_name = :"#{mounted_as}_alt_text"
    if model.respond_to?(method_name)
      model.send(method_name)
    else
      default
    end
  end

  # @param [SanitizedFile]
  def raster_image?(new_file)
    !new_file.extension.match?(/svgz?\z/i)
  end

  def raster?
    return false if path.blank?

    !File.extname(path).match?(/\.svgz?\z/i)
  end

  def tiny_url
    raster? ? tiny.url : url
  end

  def preview_url
    raster? ? preview.url : url
  end

  def small_url
    raster? ? small.url : url
  end

  def medium_url
    raster? ? medium.url : url
  end

  def large_url
    raster? ? large.url : url
  end

  def hd_url
    raster? ? hd.url : url
  end

  private

  def path_slug
    if model.respond_to?(:uuid)
      uuid = model.uuid.to_s
      "#{uuid[0..2]}/#{uuid[3..5]}/#{uuid[6..7]}/#{uuid}"
    else
      id = model&.id.to_i
      "#{id / 1000}/#{id}"
    end
  end
end
