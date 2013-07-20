class DailyRecord < ActiveRecord::Base
  attr_accessible :user_id, :question_message, :plaintext_message
  attr_accessor :plaintext_message
  before_save :encrypt_message

  def encrypt_message
    encryptor = get_encryptor
    self.message = encryptor.encrypt_and_sign(plaintext_message) if encryptor
  end

  def decrypt_message
    encryptor = get_encryptor
    self.plaintext_message = encryptor.decrypt_and_verify(self.message) if encryptor
  end

  def get_encryptor
    user = User.find_by_id(self.user_id)
    if user
      secret = Digest::SHA1.hexdigest(user.password_hash)
      return ActiveSupport::MessageEncryptor.new(secret)
    else
      return nil
    end
  end
end
