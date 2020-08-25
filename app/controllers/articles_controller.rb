class ArticlesController < ApplicationController

	def index
		# チームページから遷移してきた場合
		if params[:team_id]
		  @team = Team.find_by(id: params[:team_id])
		  @articles = Article.where(team_id: params[:team_id]).order(created_at: :desc)
		# タグの名前で検索する場合
		elsif params[:tag_name]
		  @tag = params[:tag_name]
		  @articles = Article.tagged_with("#{params[:tag_name]}").order(created_at: :desc)
		else
		  @articles = Article.all.order(created_at: :desc)
		end
		@tags = ActsAsTaggableOn::Tag.most_used(5)
		@num = (1...6)
		# いいねの多い投稿ランキング
		@favorite_ranks = Article.find(Favorite.group(:article_id)
			     .order('count(article_id) desc').limit(5).pluck(:article_id))
		# コメントの多い投稿
		@comment_ranks = Article.find(Comment.group(:article_id)
			     .order('count(article_id) desc').limit(5).pluck(:article_id))
		# 投稿の多いチームランキング
		@post_ranks = Team.find(Article.group(:team_id)
			     .order('count(team_id) desc').limit(5).pluck(:team_id))
	end

	def show
		@article = Article.find(params[:id])
		@comment = Comment.new
	end

	def new
		@article = Article.new
		gon.available_tags = Article.tags_on(:tags).pluck(:name)
	end

	def create
		@team = current_user.team
		@article = Article.new(article_params)
		@article.team_id = @team.id
		if @article.save
		   @article.create_notification_article(current_user)
		   redirect_to article_path(@article)
		else
			render :new
		end
	end

	def edit
		@article = Article.find(params[:id])
		gon.article_tags = @article.tag_list
		gon.available_tags = Article.tags_on(:tags).pluck(:name)
	end

	def update
		@article = Article.find(params[:id])
		if @article.update(article_params)
		   redirect_to article_path(@article)
		else
			render :edit
		end
	end

	def destroy
		@article = Article.find(params[:id])
		if @article.destroy
		   redirect_to articles_path
		else
			render :edit
		end
	end

	private
	def article_params
		params.require(:article).permit(:title, :body, :image, :tag_list)
	end
end