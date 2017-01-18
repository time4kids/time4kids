FactoryGirl.define do
  factory :user do
    email { Faker::Internet.email }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    title { Faker::Name.title }
  end

  factory :admin_user, parent: :user do
    roles       { [FactoryGirl.create(:admin_role)] }
  end

  factory :role do
    name        { "Role_#{rand(9999)}" }
  end

  factory :admin_role, parent: :role do
    name 'Admin'
  end
end
