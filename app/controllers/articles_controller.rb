class ArticlesController < ApplicationController
    before_action :set_article, only: [:edit, :update, :show, :destroy]
    
    
    def index
        @articles = Article.all
    end
    
    def new
       @article = Article.new
    end
    def edit
        
    end
    def create
        #render plain: params[:article].inspect
        @article = Article.new(article_params)
        @article.save
        if @article.save
            flash[:notice] = "You made the article, Woo!"
            redirect_to article_path(@article)
        else
            flash[:notice] = "you done fucked up!"
            render 'new'
        end
    end
    def update
       
       if @article.update(article_params)
           flash[:notice] = "Successfully updated this stuffs"
           redirect_to article_path(@article)
       else
           render 'edit'
       end
           
        
    end
    def show
       
    end
    def destroy
       @article.destroy
       flash[:notice] = "you killed that one!"
       redirect_to articles_path
    end
    private
        def set_article
            @article = Article.find(params[:id]) 
        end
        def article_params
            params.require(:article).permit(:title, :description) 
            
        end
  
end