module UsersHelper

  # 引数で与えられたユーザーのGravatar画像を返す
  # 1) Use option argument
  # def gravatar_for(user, options = { size: 80 })
  # 2) Use keyword argument (same as 1)
  def gravatar_for(user, size: 80)
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    # 1)
    # size = options[:size]
    # 2) nothing to do 
    #
    
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag(gravatar_url, alt: user.name, class: "gravatar")
  end
end