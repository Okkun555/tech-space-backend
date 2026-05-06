class Api::PostsController < ApplicationController
  def create
    post = current_profile.posts.build(posts_params)
    post.save!

    render json: {
      data: PostSerializer.render_as_json(post)
    }, status: :created
  end

  private
  def posts_params
    params.expect(posts: [ :content, images: [] ])
  end
end
