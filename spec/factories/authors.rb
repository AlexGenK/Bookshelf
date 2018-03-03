FactoryBot.define do
  factory :author, class: Author do
    sequence(:name) { |n| "John Doe #{n}" }
    bio "Born and die"
  end
end