# frozen_string_literal: true

class User < ::ApplicationRecord
  ROLES = %i(school student).freeze
  enum role: ROLES
  class << self
    ROLES.each { |role| alias_method role.to_s.pluralize, role }
  end

  belongs_to :profile, polymorphic: true, optional: true, touch: true
  accepts_nested_attributes_for :profile

  validates :role, presence: true
  validates :email, presence: true, uniqueness: true

  devise :database_authenticatable, :registerable, :trackable, :validatable,
    :confirmable, :jwt_authenticatable, jwt_revocation_strategy: JWTBlacklist

  has_attached_file :avatar,
    styles: {
      original: '750x>'
    },
    filename_cleaner: ->(filename) {
      ext = File.extname(filename).downcase
      "#{Digest::SHA1.hexdigest(filename).slice(0..10)}#{ext}"
    },
    default_url: ''

  validates_attachment :avatar,
    content_type: { content_type: %w(image/jpeg image/gif image/png) },
    size: { in: 0..10.megabytes },
    default_url: ''

  api_accessible :v1_default do |t|
    t.add :id
    t.add :role
    t.add :email
    t.add :first_name
    t.add :last_name
    t.add :full_name
    t.add :avatar
    t.add :is_active
  end

  api_accessible :v1_self, extend: :v1_default do |t|
    t.add :profile, template: :v1_default
    t.add :created_at
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def assign_attributes(attrs)
    return super(attrs) unless attrs[:role]

    if attrs[:role].is_a?(Integer) || attrs[:role].to_s =~ /\d/
      attrs[:role] = ROLES[attrs[:role].to_i].to_s
    end

    super(attrs)
  end

  def build_profile(params)
    self.profile =  if school?
        SchoolProfile.new(params)
      else student?
        StudentProfile.new(params)
      end
  end

  def role_specific_template(template_name)
    role_specific = :"v1_#{role}_#{template_name}"

    if respond_to?("api_accessible_#{role_specific}?")
      role_specific
    else
      :"v1_#{template_name}"
    end
  end
end
