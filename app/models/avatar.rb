class Avatar < ApplicationRecord
  has_one :user

  def total_destroy
    image_deleted = Cloudinary::Uploader.destroy(self.public_id)
    if image_deleted["result"] == "ok"
      self.destroy
      return true
    else
      return false
    end
  end
end
