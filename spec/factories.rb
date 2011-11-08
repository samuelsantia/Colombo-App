# Factory User model
Factory.define :user do |user|
  user.name                   "Samuel Santiago"
  user.nick                   "samuelsantia"
  user.email                  "samuelsantia@gmail.com"
  user.password               "foobar"
  user.password_confirmation  "foobar"
end

Factory.define :gal_category do |category|
  category.name        "Category name"
  category.description "Category description"
  category.permalink   "category-permalink"
  category.status      1
end