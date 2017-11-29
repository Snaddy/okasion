class User < ActiveRecord::Base

  has_many :events, dependent: :destroy
  # Include default devise modules. Others available are:
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable,
         :omniauthable, :omniauth_providers => [:facebook, :google_oauth2]

  validates :name, presence: true
  validates_length_of :name, maximum: 50
  validates_acceptance_of :accept, allow_nil:false, on: :create, message: 'You must agree to the Privacy Policy and Terms of Service before signin up'

  def self.from_omniauth(auth)
  	where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
    	user.email = auth.info.email
      user.name = auth.info.name
    	user.password = Devise.friendly_token[0,20]
    	user.skip_confirmation!
    end
  end

  def self.find_for_google_oauth2(access_token, signed_in_resource=nil)
    data = access_token.info
    user = User.where(email: data['email']).first

    unless user
         user = User.create(name: data['name'],
            email: data['email'],
            password: Devise.friendly_token[0,20])

     end
    user
    user.skip_confirmation!
end
  
end
