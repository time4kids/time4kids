class User < ::ApplicationRecord

  ROLES = [:teacher, :student]
  enum role: ROLES
  class << self
    ROLES.each { |role| alias_method role.to_s.pluralize, role }
  end
  ROLE_INTEGERS = Hash[ROLES.map.with_index.to_a].with_indifferent_access

  belongs_to :profile, polymorphic: true, optional: true, dependent: :delete

  validates :role, presence: true
  validates :email, presence: true, uniqueness: true

  devise :database_authenticatable, :registerable, :trackable, :validatable,
    :jwt_authenticatable, jwt_revocation_strategy: JWTBlacklist

  accepts_nested_attributes_for :profile

  has_attached_file :avatar,
    styles: {
      original: '750x>'
    },
    filename_cleaner: -> (filename) {
      ext = File.extname(filename).downcase
      "#{Digest::SHA1.hexdigest(filename).slice(0..10)}#{ext}"
    },
    default_url: ''

  validates_attachment :avatar,
    content_type: { content_type: %w(image/jpeg image/gif image/png) },
    size: { in: 0..10.megabytes },
    default_url: ''

end
