require "image_processing/mini_magick"

class ArchiveUploader < Shrine
  include ImageProcessing::MiniMagick
  plugin :processing
  plugin :versions
  plugin :remove_attachment
  plugin :determine_mime_type
  plugin :cached_attachment_data
  plugin :delete_raw
  plugin :store_dimensions

  Attacher.validate do
    validate_max_size 15.megabyte, message: "is too large (max is 15 MB)"
    # validate_mime_type_inclusion ['image/jpg', 'image/jpeg', 'image/png']
  end
end