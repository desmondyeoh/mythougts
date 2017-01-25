class PostsController < ApplicationController
  before_action :find_post, only: [:edit, :update, :destroy, :show]

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      current_user.posts << @post
      add_tags
      redirect_to home_url
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @post.update_attributes(post_params)
      delete_tags
      add_tags
      redirect_to root_url, notice: 'Post updated'
    else
      render 'edit', notice: 'Post cannot be updated'
    end
  end

  def destroy
    if @post.destroy
      redirect_to home_url
    else
      render 'show', notice: 'Cannot delete post'
    end
  end

  def show
  end

  private
    def post_params
      params.require(:post).permit(:content)
    end

    def find_post
      @post = Post.find(params[:id])
    end

    def add_tags
      tags = @post.content.scan(/#\w+/).flatten
      tags.each do |tagname|
        tag = Tag.find_or_create_by(name: tagname)
        @post.tags << tag
      end
    end

    def delete_tags
      @post.tags.destroy_all
      @post.taggings.destroy_all
    end
end
