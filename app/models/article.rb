class Article < ActiveRecord::Base
  mount_uploader :image, ArticleImageUploader
end
