# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# メンバーサンプル
# admin = true
Admin.find_or_create_by!(email: ENV['ADMIN_EMAIL']) do |admin|
  admin.password = ENV['ADMIN_PASSWORD']
end


# admin = false
olivia = EndUser.find_or_create_by!(email: "1111@example.com") do |end_user|
  end_user.name = "Olivia"
  end_user.password = "password"
  end_user.profile_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample_user1.jpg"), filename:"sample_user1.jpg")
  end_user.self_introduction = "サンプルのユーザーです。よろしくね！"
  end_user.is_active = true
end

tarou = EndUser.find_or_create_by!(email: "2222@example.com") do |end_user|
  end_user.name = "太郎"
  end_user.password = "password"
  end_user.profile_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample_user2.jpg"), filename:"sample_user2.jpg")
  end_user.self_introduction = "サンプルのユーザーです。（自己紹介文は編集リンクから設定できるよ！）"
  end_user.is_active = true
end

hanako = EndUser.find_or_create_by!(email: "3333@example.com") do |end_user|
  end_user.name = "花子"
  end_user.password = "password"
  end_user.profile_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample_user3.jpg"), filename:"sample_user3.jpg")
  end_user.self_introduction = "サンプルのユーザーです。頑張ります。"
  end_user.is_active = true
end


#お題の投稿
onigiri = Theme.find_or_create_by!(id: 1) do |theme|
  theme.title = "おにぎり"
  theme.detail = "サンプルの投稿です。おにぎりのイラストを描いてください。食べられたりしていてもかまいません。"
  theme.is_active = true
  theme.theme_tag_name = "食べ物"
  theme.reference_images = nil
  theme.end_user = olivia
end

Theme.find_or_create_by!(id: 2) do |theme|
  theme.title = "魔女"
  theme.detail = "サンプルの投稿です。魔女のコスプレをした女の子のイラストが見たいです。画像のように大きめのとんがりボウシをかぶっているとよろこびます。"
  theme.is_active = true
  theme.theme_tag_name = "魔女 女の子"
  theme.reference_images = nil
  # theme.reference_images.attach(io: File.open("#{Rails.root}/db/fixtures/sample_reference_image1.jpg"), filename: "sample_reference_image1.jpg")
  # theme.reference_images = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample_reference_image1.jpg"), filename:"sample_reference_image1.jpg")
  theme.end_user = olivia
end

Theme.find_or_create_by!(id: 3) do |theme|
  theme.title = "鳥"
  theme.detail = "サンプルの投稿です。種類はなんでもいいです！！"
  theme.is_active = true
  theme.theme_tag_name = "鳥"
  theme.reference_images = nil
  theme.end_user = olivia
end

Theme.find_or_create_by!(id: 4) do |theme|
  theme.title = "架空 のこ"
  theme.detail = "サンプルの投稿です。人気Vtuberの「架空のこ」ちゃんのイラストが見たい！"
  theme.is_active = true
  theme.theme_tag_name = "Vtuber 女の子 バーチャルYouTuber"
  theme.reference_images = nil
  theme.end_user = tarou
end

Theme.find_or_create_by!(id: 5) do |theme|
  theme.title = "あなたのオリジナルキャラ"
  theme.detail = "サンプルの投稿です。（概要は無言でも大丈夫です！）"
  theme.is_active = true
  theme.theme_tag_name = "オリジナル"
  theme.reference_images = nil
  # theme.reference_images.attach(io: File.open("#{Rails.root}/db/fixtures/sample_reference_image1.jpg"), filename: "sample_reference_image1.jpg")
  theme.end_user = hanako
end

#お題への挑戦←これによってイラスト投稿が可能となる
ChallengeTheme.find_or_create_by!(id: 1) do |challenge_theme|
  challenge_theme.end_user_id = 1
  challenge_theme.theme_id = 1
end

ChallengeTheme.find_or_create_by!(id: 2) do |challenge_theme|
  challenge_theme.end_user_id = 1
  challenge_theme.theme_id = 2
end

ChallengeTheme.find_or_create_by!(id: 3) do |challenge_theme|
  challenge_theme.end_user_id = 2
  challenge_theme.theme_id = 2
end

ChallengeTheme.find_or_create_by!(id: 4) do |challenge_theme|
  challenge_theme.end_user_id = 3
  challenge_theme.theme_id = 2
end


#イラスト投稿
# Illastration.find_or_create_by!(id: 1) do |illustration|
#   illustration.title = "おにぎり"
#   illustration.detail = "サンプルの投稿です。セルフチャレンジしました。"
#   illustration.illustration_tag_name = "オリジナル 食べ物 主食"
#   # illustration.challenged_images.attach(io: File.open("#{Rails.root}/db/fixtures/sample_reference_image1.jpg"), filename: "sample_reference_image1.jpg")
#   illustration.theme = onigiri
#   illustration.end_user = olivia
# end


end_users = EndUser.where(id: 1..3)
themes = Theme.where(id: 1..5)

#コメントのサンプルリスト
theme_comments = [
  '素敵な投稿ですね！',
  '興味深いです。',
  'やってみたいです！',
  'いいですね！',
  '面白いです！'
]

end_users.each do |end_user|
  themes.each do |theme|
    num_theme_comments = rand(0..1)
    next if num_theme_comments.zero?

    #いいね追加
    #イラストのテストデータ作れたら(ブックマークも)


    #コメント追加
    comment_text = theme_comments.sample
    ThemeComment.find_or_create_by!(
      end_user_id: end_user.id,
      theme_id: theme.id
    ) do |c|
      c.comment = comment_text
    end
  end

  #フォロー追加
  following_end_users = end_users - [end_user]
  following_end_users.shuffle.take(rand(1..2)).each do |following_end_user|
    FollowRelationship.find_or_create_by!(
      follower_id: end_user.id,
      followed_id: following_end_user.id
    )
  end
end