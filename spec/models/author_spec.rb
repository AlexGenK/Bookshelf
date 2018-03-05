require 'rails_helper'

RSpec.describe Author, type: :model do
  subject { build(:author) }

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  it "is not valid with empty name" do
    subject.name = ''
    expect(subject).to_not be_valid
  end
end
