FactoryBot.define do
  factory :book, class: Book do
    sequence(:title) { |n| "book#{n}" }
    description "lorem ipsum"
    association :category, factory: :category

    after(:create) do |book, evaluator|
      book.authors << create(:author)
    end
  end
end