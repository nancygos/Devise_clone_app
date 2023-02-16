class User < ApplicationRecord
    attr_accessor :password

    validates :first_name, presence: true
    validates :last_name, presence: true
    validates :mobile, presence: true
    validates :date_of_birth, presence: true
    validates :email, uniqueness: true
    validates :password, presence: true, confirmation: true , length: {in: 4..20}, on: :create

    before_save :encrypt_password

    #to check authenticaiton in login data
    def self.authenticate(email , password)
        user = find_by_email(email)
        if user && user.check_password(password)
            return user
        end
    end

    def check_password(string)
        if encrypt(string) == self.encrypted_password
            return true
        end
    end

    # to perform encryption
    protected
    def encrypt_password
        return if password.blank?
       self.encrypted_password = encrypt(password)
    end

    def encrypt(string)
        Digest::SHA1.hexdigest(string)
    end
end
