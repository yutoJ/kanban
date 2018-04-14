class ProfileImageUploader < CarrierWave::Uploader::Base
  include Cloudinary::CarrierWave
end
