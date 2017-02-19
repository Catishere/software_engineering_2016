class VotesController < ApplicationController

    def show
        Vote.order(:created_at).find(:all).each do |vot|
            render json: vot
        end
    end

    def create
        if !(params[:article_id].empty? || params[:value].empty?)
            if Article.where(id: params[:article_id]).empty?
                render text: "Article doesn't exist"
            else
                Vote.create(article_id: params[:article_id], value: params[:value])
                @vote = Vote.last
                render json: @vote
            end
        else
            render text: "CREATE ERROR: INVALID INFO"
        end
    end
end
