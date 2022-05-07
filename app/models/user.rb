class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:google_oauth2, :github]
  
  has_many :departments
# 找到user的話就登入，找不到就create新的user
def self.create_from_provider_data(provider_data)
  where(email: provider_data.info.email).first_or_create do |user|
    user.email = provider_data.info.email
    user.password = Devise.friendly_token[0, 20]
    # user.name = provider_data.info.last_name
    user.provider = provider_data.provider
    user.uid = provider_data.uid
  end
end

#Github
def self.from_omniauth(auth)  
  where(provider: auth.provider, uid: auth.uid).first_or_create do |user| # 在資料庫找不到使用者的話就創一個新的使用者
    user.provider = auth.provider # 登入資訊1
    user.uid = auth.uid           # 登入資訊2
    user.email = auth.info.email
    user.password = Devise.friendly_token[0,20]
  end
end

