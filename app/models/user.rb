class User < ActiveRecord::Base

  acts_as_token_authenticatable

  has_many :events, dependent: :destroy
  # Include default devise modules. Others available are:
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable, :lockable,
         :omniauthable, :omniauth_providers => [:facebook, :google_oauth2]

  validates :name, presence: true, allow_blank: false
  validates :city, presence: true, allow_blank: true
  validates_length_of :name, maximum: 50
  validates_acceptance_of :accept, allow_nil:true, on: :create, message: 'You must agree to the Privacy Policy and Terms of Service before signin up'

  def self.from_omniauth(auth)
  	where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
    	user.email = auth.info.email
      user.name = auth.info.name
    	user.password = Devise.friendly_token[0,20]
    	user.skip_confirmation!
      user.confirmed_at = DateTime.current
    end
  end

  def self.from_omniauth_api(auth = {})
    where(provider: auth["provider"], uid: auth["uid"]).first_or_create do |user|
      user.email = auth["email"]
      user.name = auth["name"]
      user.password = Devise.friendly_token[0,20]
      user.skip_confirmation!
      user.confirmed_at = DateTime.current
    end
  end

end
