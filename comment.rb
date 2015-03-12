class Comment
  attr_accessor :user, :text

  def initialize(username, text)
    @user = username
    @text = text
  end
end