require_relative "../lib/rails_join"
require 'fruity'

[5, 25, 100].each do |n|
  compare :join_without_safe_buffer_awareness, :join_with_safe_buffer_awareness, :on => ["A typical short string"] * n
end