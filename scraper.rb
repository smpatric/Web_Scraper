require 'open-uri'
require 'nokogiri'
require 'colorize'
require_relative 'post'
require_relative 'comment'

@url = ARGV[0]

html_file = open(@url)

parsed_html = Nokogiri::HTML(html_file.read)

def scrape(doc) 
  post_title = ''
  post_id = ''
  post_points = 0
  usernames = []
  comment_texts = []

  doc.search('.subtext > span:first-child').map { |span| post_points = span.inner_text} #post_points
  doc.search('.title > a' ).map { |link| post_title = link.inner_text} #post_title
  doc.search('.title > a' ).map { |link| post_id = link['href']} #post_id

  new_post = Post.new(post_title, @url, post_points, post_id)

  doc.search('.comhead > a:first-child').map {|element| usernames <<  element.inner_text} #usernames
  doc.search('.comment > font:first-child').map { |font| comment_texts << font.inner_text} #comment_texts

  comments = usernames.zip(comment_texts)

  comments.each do |record|
    new_post.add_comment(Comment.new(record[0], record[1]))
  end
  puts "Title: #{new_post.title}".colorize(:red)
  puts "URL: #{new_post.url}".colorize(:red) 
  puts "Total Points: #{new_post.points}".colorize(:red)
  puts "Post ID: #{new_post.post_id}".colorize(:red)
  new_post.comments
end

scrape(parsed_html)


