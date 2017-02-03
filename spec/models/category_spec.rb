require 'rails_helper'

describe Category do
  it { should have_many :products }
  it { should validate_presence_of :name }
  it 'it should have the name it is saved with' do
    cat = Category.new(:name => 'Jackets')
    cat.save
    expect(cat.name).to eql("Jackets")
  end
end
