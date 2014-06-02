class Post < ActiveRecord::Base
  belongs_to  :user
  has_many  :comments
  validates :category, :inclusion => { :in => ["class","grades","activities"], :message => "class, grades, activities 중 하나를 선택하셔야 합니다." }
  validates :title, :presence => { :message => "제목을 반드시 입력하셔야 합니다." }
  has_many :vote_posts
end
