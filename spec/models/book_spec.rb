require 'rails_helper'

RSpec.describe Book, type: :model do
  subject { build(:book) }

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  it "is not valid with empty title" do
    subject.title = ''
    expect(subject).to_not be_valid
  end
end
