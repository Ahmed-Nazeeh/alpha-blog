class ArticlesController < ApplicationController

    def show
        #byebug
        @article = Article.find(params[:id])
    end

    def index
        @articles = Article.all
    end

    def create
        #render plain: params[:article] # output of this code =>{"title"=>"123", "description"=>"456789"}
        #@article = Article.new(params[:article])
        @article = Article.new(params.require(:article).permit(:title, :description))
        #render plain: @article.inspect  #test
        if @article.save
            flash[:notice] = "Article was created successfully"
             redirect_to article_path(@article) # or redirect_to @article
        else
            render 'new'
        end
    end

    def new
        @article = Article.new
    end

    def edit
        #byebug
        @article = Article.find(params[:id])
    end

    def update
        @article = Article.find(params[:id])
        if @article.update(params.require(:article).permit(:title, :description))
            flash[:notice] = "Article was updated successfuly"
            redirect_to @article
        else
            render 'edit'
        end
    end
end