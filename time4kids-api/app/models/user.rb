class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :assignments
  has_many :roles, through: :assignments
  before_create :set_default_role

  alias authenticate valid_password?


def self.from_token_payload(payload)
  self.find payload['sub']
end

  private

  def set_default_role
    self.roles ||= Role.find_by_name('registered')
  end
end
