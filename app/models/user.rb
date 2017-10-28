class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable#, :omniauthable,
         #omniauth_providers: [:wechat]

  GENDERS = I18n.t("user.gender")

  scope :name_includes, ->(search) {
	  current_scope = self
	  search.split.uniq.each do |word|
	    current_scope = current_scope.where(
	    	%{
	    		email ILIKE ? 
	    		OR nick_name ILIKE ?
	    	}, 
	    	"%#{word}%",
	    	"%#{word}%"
	    )  
	  end
	  current_scope
	}

	def self.ransackable_scopes(auth_object = nil)
	  [ :name_includes ]
	end

	def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
        user.provider = auth.provider
        user.uid = auth.uid
        user.email = auth.info.email || "#{auth.uid}@storychain.com"
        user.nick_name = auth.info.nickname
        user.portrait_url = auth.info.headimgurl
        user.password = Devise.friendly_token[0,20]
        user.save
      end
  end
end
