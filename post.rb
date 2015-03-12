require 'colorize'

class Post
  attr_accessor :title, :url, :points, :post_id, :comments
  

  def initialize(title, url, hn_points, post_id)
    @title = title
    @url = url
    @points = hn_points
    @post_id = post_id
    @comments = []
  end

  def comments
    #returns all comments in a post
    @comments.each do |comment|
      puts "- - - - - - - - - - - - - - - -".colorize(:light_green)
      puts "Username: #{comment.user}\n".colorize(:light_yellow)
      puts "Comment:\n#{comment.text}\n".colorize(:light_green)
    end
  end

  def add_comment(comment)
    #adds comment to post's comments
    @comments << comment
  end
end