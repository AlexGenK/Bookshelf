FactoryBot.define do
  factory :super_admin, class: User do
    username              "super_admin"
    email                 "superadmin@mail.no"
    password              "123456"
    superadmin_role       true
    admin_books_role      false
    admin_categories_role false
  end

  factory :books_admin, class: User do
    username              "books_admin"
    email                 "books_admin@mail.no"
    password              "123456"
    superadmin_role       false
    admin_books_role      true
    admin_categories_role false
  end

  factory :categories_admin, class: User do
    username              "categories_admin"
    email                 "categories_admin@mail.no"
    password              "123456"
    superadmin_role       false
    admin_books_role      false
    admin_categories_role true
  end
end