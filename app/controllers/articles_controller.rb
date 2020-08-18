class ArticlesController < ApplicationController

	def index
		@articles = Article.all
		# チームページから遷移してきた場合
		if params[:team_id]
		  @team = Team.find_by(id: params[:team_id])
		  @articles = Article.where(team_id: params[:team_id])
		# タグの名前で検索する場合
		elsif params[:tag_name]
		  @tag = params[:tag_name]
		  @articles = Article.tagged_with("#{params[:tag_name]}")
		end
	end

	def show
		@article = Article.find(params[:id])
		@comment = Comment.new
	end

	def new
		@article = Article.new
	end

	def create
		@team = current_user.team
		@article = Article.new(article_params)
		@article.team_id = @team.id
		if @article.save
		   redirect_to article_path(@article)
		else
			render :new
		end
	end

	def edit
		@article = Article.find(params[:id])
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