FactoryGirl.define do
  factory(:user) do
    user_name('Frank')
    email('frank@frank.frank')
    password('password')
    password_confirmation('password')
  end
end
FactoryGirl.define do
  factory(:category) do
    name('Bratwurst')
  end
end
