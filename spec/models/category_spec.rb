require 'rails_helper'

RSpec.describe Category, type: :model do
  subject { build(:category) }

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  it "is not valid with empty name" do
    subject.name = ''
    expect(subject).to_not be_valid
  end

  it "can set default category" do
    subject
    expect(Category.default_category.name).to eq("Other")
  end
end
