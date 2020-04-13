PlanQuestion.create(title: "強いニーズあるか？", content: "「あった方がいい」ではなく「ないと困る」「待ってでも必要」「絶対欲しい」「これでないとダメ」というもの。")
PlanQuestion.create(title: "今までないか？あるいはその他よりも優れているか？")
PlanQuestion.create(title: "自分（達）にしかできないかor自分（達）の強みを活かせるかor自分（達）ならではがあるか？ やるべきか？やりたいか？やれるのか？")
PlanQuestion.create(title: "お金は儲かりそうか？", content: "収益シュミレーションしてみる。数字で計算。売上-コスト＝利益")
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
if Rails.env == "development"
  (1..10).each do |i|
    User.create!(email: "test#{i}@example.com", password: "password", password_confirmation: "password")
  end
  User.all.each do |user|
    user.employees.create!(user_id: user.id,company_id:1)
    (1..10).each do |i|
      a =Idea.create(title:"#{i}回目",content:"私は#{user.email}です#{i}回目",user_id:user.id,open:true)
      a.likes.create!(user_id:user.id)
    end
  end

end
