class Archive < ApplicationRecord
  include ArchiveUploader[:archive]
  
  belongs_to :user
  belongs_to :folder

  validates :archive, :user, presence: true

  def structure_archive
    {
      id: id,
      title: title,
      url: archive_url,
      type: archive.mime_type
    }
  end
end
