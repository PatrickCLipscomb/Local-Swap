require 'rails_helper'

describe Review do
  it { should belong_to :product}
  it { should belong_to :user}
  it { should validate_presence_of :name }
  it { should validate_presence_of :content }
  it { should validate_presence_of :rating }
end
