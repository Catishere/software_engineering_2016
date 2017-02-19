class ArticlesController < ApplicationController

    def show
        if !params[:id].empty?
            if Article.where(id: params[:id]).empty?
                render text: "Couldn't find article with such ID."
            else
                @article = Article.find(params[:id])
                render json: @article
            end
        else
            Article.order(:name).find(:all).each do |art|
                render json: @art
            end
        end
    end

    def create
        if !params[:name].empty?
            if Article.where(name: params[:name]).empty?
                Article.create(name: params[:name])
            end

            @article = Article.find(params[:name])
            render json: @article
        else
            render text: "ERROR"
        end
    end

    def showfull
        if !params[:id].empty?
            if Article.where(id: params[:id]).empty?
                render text: "Couldn't find article with such ID."
            else
                @comc = 0
                @votc = 0

                @article = Article.find(params[:id])

                Comment.where(article_id: params[:id]).each do
                    @comc++
                end

                Vote.where(article_id: params[:id]).each do
                    @votc++
                end

                render json: @article.merge(@comc).merge(@votc)
            end
        else
            Article.order(:name).find(:all).each do |art|
                @comc = 0
                @votc = 0

                Comment.where(article_id: art.id).each do
                    @comc++
                end

                Vote.where(article_id: art.id).each do
                    @votc++
                end

                render json: art.merge(@comc).merge(@votc)
            end
        end
    end
end
