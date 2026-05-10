class Api::PostsController < ApplicationController
  def index
    pagy, posts = pagy(Post.all.order(created_at: :desc), limit: params[:limit])
    render json: {
      data: PostSerializer.render_as_json(posts),
      pagination: PaginationSerializer.render(pagy)
    }
  end

  def create
    @post = current_profile.posts.build(posts_params)
    authorize @post
    @post.save!

    render json: {
      data: PostSerializer.render_as_json(@post)
    }, status: :created
  end

  def destroy
    @post = Post.find(params[:id])
    authorize @post
    @post.destroy!


    render json: {
      data: PostSerializer.render_as_json(@post)
    }, status: :ok
  end

  private
  def posts_params
    params.expect(posts: [ :content, images: [] ])
  end
end
