class SnsImageUploader < CarrierWave::Uploader::Base
  include Cloudinary::CarrierWave
end
