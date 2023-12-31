class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :stories
  validates :username, presence: true, uniqueness: true
  # 驗證username必填，且不得重複

  has_one_attached :avatar


end
