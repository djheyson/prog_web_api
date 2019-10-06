class Folder < ApplicationRecord
  belongs_to :user

  has_many :archives, dependent: :destroy
  has_many :folders, dependent: :destroy

  def structure_folder
    {
      id: id,
      title: title,
      folder_id: folder_id
    }
  end
end
