# Factory User model
Factory.define :user do |user|
  user.name                   "Samuel Santiago"
  user.nick                   "samuelsantia"
  user.email                  "samuelsantia@gmail.com"
  user.password               "foobar"
  user.password_confirmation  "foobar"
end