FactoryGirl.define do
  factory(:user) do
    user_name('Admin')
    address('100 N Blandena, Portland, OR')
    latitude('45')
    longitude('45')
    email('frank@frank.frank')
    password('password')
    password_confirmation('password')
  end
  factory(:category) do
    name('Bratwurst')
  end
end
# FactoryGirl.define do
#   factory(:product) do
#     name('Prop')
#     price('3')
#     association :category
#     association :user
#   end
# end
