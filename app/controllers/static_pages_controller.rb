class StaticPagesController < ApplicationController
  before_action :signed_in_user, only: [:home]

  def home
    @post = Post.new
    @posts = current_user.posts.order(created_at: :desc)
  end

  def tag
    @tag = Tag.find_by(name: params[:name])
    @posts = @tag.posts
  end

  def search
    @query = params[:query]
    @posts = Post.where('lower(content) LIKE ?', "%#{@query.downcase}%").order(created_at: :desc)
  end

  private
    def signed_in_user
      unless signed_in?
        redirect_to signin_url, notice: 'Please sign in'
      end
    end
end
