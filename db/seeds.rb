site_urls = [
  "https://twitter.com/home",
  "https://www.youtube.com/",
  "https://www.instagram.com/",
  "https://www.yahoo.co.jp/",
  "https://it-kingdom.com/"
]

5.times do |i|
  User.create!(
    name: "ユーザー#{i + 1}",
    email: "user#{i + 1}@example.com",
    introduction: "こんにちは、ユーザー#{i + 1}です。",
    is_active: true,
    uid: "user#{i + 1}id",
    avatar: '/images/default-avatar.jpg',
    is_chef: (i % 2).zero?
  )
end

User.all.each_with_index do |user, i|
  3.times do |j|
    user.recipes.create!(
      name: "レシピ#{i * 3 + j + 1}",
      description: "これはユーザー#{i + 1}のレシピ#{j + 1}です。",
      published: true
    )
  end
end

users = User.all
user  = users.first
following = users[1..2]
following.each { |followed| user.follow(followed) }

Recipe.all.each_with_index do |recipe, i|
  5.times do |j|
    recipe.ingredients.create!(
      name: "食材#{i * 5 + j + 1}",
      description: "これはレシピ#{i + 1}の食材#{j + 1}です。"
    )
    recipe.recipe_images.create!(
      url: "/images/recipe#{i + 1}_image#{j + 1}.jpg"
    )
  end

  (2..5).to_a.sample.times do |j|
    recipe.steps.create!(
      description: "これはレシピ#{i + 1}のステップ#{j + 1}の詳細説明です。",
      order: j + 1
    )
  end
  rand(4).times do
    recipe.recipe_sites.create!(
      url: site_urls.sample
    )
  end
end


User.all.each_with_index do |user, i|
  Recipe.all.sample(3).each do |recipe|
    user.likes.create!(recipe: recipe)
    user.user_ingredients.create!(recipe: recipe, checked: (i % 2).zero?)
  end
end

User.all.each_with_index do |user, _i|
  rand(4).times do
    user.user_sites.create!(url: site_urls.sample)
  end
end
