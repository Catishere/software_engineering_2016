class CommentsController < ApplicationController

    def show
        if !params[:id].empty?
            if Comment.where(id: params[:id]).empty?
                render text: "Couldn't find comment with such ID."
            else
                @comment = Comment.find(params[:id])
                render json: @comment
            end
        else
            Comment.order(:content).find(:all).each do |com|
                render json: @com
            end
        end
    end

    def create
        if !params[:article_id].empty?
            if Article.where(id: params[:article_id]).empty?
                render text: "Couldn't find article with such id."
            else
                Comment.create(article_id: params[:article_id], content: params[:content])
                @comment = Comment.last
                render json: @comment
            end
        else
            render text: "ERROR: ARTICLE NOT FOUND!"
        end
    end

    def commentshow
        if !params[:id].empty?
            Comment.order(:content).where(article_id: params[:id]).each do |com|
                render json: com
            end
        else
            render text: "Invalid ID"
        end
    end

end
