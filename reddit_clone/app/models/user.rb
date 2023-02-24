# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  username        :string           not null
#  password_digest :string           not null
#  session_token   :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# F - self.find_by_credientials
# I - is_password?(password)
# G - generate_session_token
# V - validations
# A - attr_reader
# P - password=(password)
# E - ensure_session_toke
# R - reset_session_token




class User < ApplicationRecord

    validates :username, :session_token, presence: true, uniqueness: true
    validates :password_digest, presence: true
    validates :password, length: {minimum: 6}, allow_nil: true

    before_validation :ensure_session_token

    
    def self.find_by_credentials(username, password)
        user = User.find_by(username: username)
        if user && User.is_password?(password)
            user
        else
            nil
        end
    end

    def is_password?(password)
        BCrypt::Password.new(self.password_digest).is_password?(password)
    end

    def generate_session_token
        token = SecureRandon::urlsafe_base64
        while User.exists?(session_token: token)
            token = SecureRandon::urlsafe_base64
        end
        token
    end

    

end
