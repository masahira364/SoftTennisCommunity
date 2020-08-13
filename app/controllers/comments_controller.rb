class CommentsController < ApplicationController

	def create
		@article = Article.find(params[:article_id])
		@comment = current_user.comments.new(comment_params)
		@comment.article_id = @article.id
		if @comment.save
		   redirect_to request.referer
		else
		   render 'articles/show'
		end
	end

	def destroy
		@comment = Comment.find_by(id: params[:id], article_id: params[:article_id])
		if @comment.destroy
		   redirect_to request.referer
		else
			render 'articles/show'
		end
	end

	private
	def comment_params
		params.require(:comment).permit(:comment)
	end
end
