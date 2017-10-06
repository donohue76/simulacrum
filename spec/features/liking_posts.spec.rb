require 'rails_helper'

before do
  # Create a user via factory_girl
  user = create :user
  # Create a post for the above user.
  post = create(:post, user_id: user.id)
  # Visit the root route
  visit '/'
end

scenario 'can like a post' do
  # Click the "like" button for the above post.
  # Expect to see a "liked-post" class appear for the button (the button will turn solid red aka Instagram).
  # Expect to see my name within the "liked by" area of the post.
end
  
scenario 'can unlike a post' do
  # Repeat the above steps.
  # Click the "like" button once more.
  # Expect to see the "unlikes-post" class on the button.
  # Expect to NOT see my name within the "liked by" area of the post
end