class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  
  has_many :posts
  has_many :likes
  has_many :comments
 
  def is_like?(post) 
    Like.find_by(user_id: self.id, post_id: post.id).present? 
  end
  
  #이미지 업로드
  mount_uploader :avatar, AvatarUploader


end
