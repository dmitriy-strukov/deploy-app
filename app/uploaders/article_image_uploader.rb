class ArticleImageUploader < BaseUploader
  storage :file
  
  version :thumb do
    process resize_and_pad: [350, 300]
  end
end
