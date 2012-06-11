class User < ActiveRecord::Base

  has_many :revisions

  def self.authenticate(email, password)
    if user = User.find_by_email(email)
      if password == user.password
        user
      end
    end
  end

end
