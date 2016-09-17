FactoryGirl.define do
  factory(:user) do
    user_name('Frank')
    email('frank@frank.frank')
    password('password')
    password_confirmation('password')
  end

  factory(:category) do
    name('Bratwurst')
  end

  factory(:product) do
    name('Prop')
    price('3')
    association :category
    association :user
  end
end
