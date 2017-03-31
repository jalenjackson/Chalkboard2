class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy,:upvote,:downvote]

  # GET /articles
  # GET /articles.json
  def index
    @articles = Article.all.order(:cached_votes_score => :desc)
    @videos = Video.all
  end

  # GET /articles/1
  # GET /articles/1.json
  def show
    impressionist(@article)

  end

  # GET /articles/new
  def new
    @article = Article.new
  end

  # GET /articles/1/edit
  def edit
  end

  # POST /articles
  # POST /articles.json
  def create
    @article = current_user.articles.build (article_params)

    if @article.save
      redirect_to @article
    else
      render 'new'
    end
  end

  # PATCH/PUT /articles/1
  # PATCH/PUT /articles/1.json
  def update
    respond_to do |format|
      if @article.update(article_params)
        format.html { redirect_to @article, notice: 'Article was successfully updated.' }
        format.json { render :show, status: :ok, location: @article }
      else
        format.html { render :edit }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  def upvote
    @article.upvote_from current_user
    redirect_to @article

  end

  def downvote
    @article.downvote_from current_user
    redirect_to @article
  end

  # DELETE /articles/1
  # DELETE /articles/1.json
  def destroy
    @article.destroy
    respond_to do |format|
      format.html { redirect_to articles_url, notice: 'Article was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def article_params
      params.require(:article).permit(:document,:image,:title,:description)
    end
end
