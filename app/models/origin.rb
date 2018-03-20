class Origin < ApplicationRecord
  has_many :users

  def rsa_public
    OpenSSL::PKey::RSA.new(public_key)
  end
end
