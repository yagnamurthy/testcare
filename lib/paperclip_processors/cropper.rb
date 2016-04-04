module Paperclip
  class Cropper < Thumbnail
    def transformation_command 
      if crop_command
        crop_command + super.join(' ').sub(/ -crop \S+/, '').split(' ')
      else
        super
      end
    end

    def crop_command 
      target = @attachment.instance
      crop_data = target.crop_data

      if crop_data && crop_data.cropping?
        ratio = 1
        ["-crop", "#{(crop_data.crop_w.to_i*ratio).round}x#{(crop_data.crop_h.to_i*ratio).round}+#{(crop_data.crop_x.to_i*ratio).round}+#{(crop_data.crop_y.to_i*ratio).round}"]
      end
    end
  end
end