# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :trackable, :confirmable
  include DeviseTokenAuth::Concerns::User

  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :last_name, presence: true
  validates :first_name, presence: true

  validate :password_complexity

  private

  def password_complexity
    # NOTE: コメントアウトしたが、英大文字・小文字・数字・記号(#?!@$%^&*-)それぞれ１文字以上含むの場合は以下に変更
    # return if password.blank? || password =~ /(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-])/
    return if password.blank? || password =~ /\A[a-zA-Z0-9#?!@$%^&*-]+\z/i

    errors.add :password, 'は英大文字・小文字・数字・記号(#?!@$%^&*-)のいずれかである必要があります'
  end
end
