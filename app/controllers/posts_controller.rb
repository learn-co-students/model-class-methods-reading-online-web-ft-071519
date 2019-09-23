class PostsController < ApplicationController
    # helper_method :params
    
    def index
        @authors = Author.all

        # If params for :author is not black then,
        if !params[:author].blank?
            # @posts = Posts that have the entered author value. 
            @posts = Post.by_author(params[:author])
        # Else if the date is not blank,
        elsif !params[:date].blank?
            # and is equivalent to "Today",
            if params[:date] == "Today"
                # @posts are from today onward.
                @posts = Post.from_today
            else
                #Else @posts are from before today.
                @posts = Post.old_news
            end
        else
            # If no filters are applied, show all posts.
            @posts = Post.all
        end
    end

    def show
        @post = Post.find(params[:id])
    end

    def new
        @post = Post.new
    end

    def create
        @post = Post.new(params)
        @post.save
        redirect_to post_path(@post)
    end

    def update
        @post = Post.find(params[:id])
        @post.update(params.require(:post))
        redirect_to post_path(@post)
    end

    def edit
        @post = Post.find(params[:id])
    end
end
