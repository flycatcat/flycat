# frozen_string_literal: true

class User < ApplicationRecord
  include Slugable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[google_oauth2 github]
  belongs_to :company
  has_many :punchcards
  has_one :profile, dependent: :delete
  accepts_nested_attributes_for :company
  
  def self.create_from_provider_data(provider_data)
    where(email: provider_data.info.email).first_or_create do |user|
      user.email = provider_data.info.email
      user.password = Devise.friendly_token[0, 20]
      user.provider = provider_data.providers
      user.uid = provider_data.uid
    end
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.provider = auth.provider 
      user.uid = auth.uid           
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
    end
  end
  
  def self.all_gender
    [
      %w[男生], %w[女生]
    ]
  end

  def self.all_role
    [
      %w[staff], %w[manager]
    ]
  end
end
