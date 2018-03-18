class User < ::ApplicationRecord

  ROLES = [:teacher, :student]
  enum role: ROLES
  class << self
    ROLES.each { |role| alias_method role.to_s.pluralize, role }
  end
  ROLE_INTEGERS = Hash[ROLES.map.with_index.to_a].with_indifferent_access

  validates :role, presence: true
  validates :email, presence: true, uniqueness: true

  devise :database_authenticatable, :registerable, :trackable, :validatable,
    :jwt_authenticatable, jwt_revocation_strategy: JWTBlacklist

  before_create :set_default_role

  api_accessible :v1_default do |t|
    t.add :id
    t.add :role_integer, as: :role
    t.add :email
    t.add :first_name
    t.add :last_name
    t.add :full_name
  end

  def full_name
    "#{first_name} #{last_name}"
  end
end
