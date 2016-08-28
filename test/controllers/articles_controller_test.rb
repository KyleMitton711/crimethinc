require 'test_helper'

class ArticlesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @article = articles(:one)
  end

  test "should get index" do
    get articles_url
    assert_response :success
  end

  test "should get new" do
    get new_article_url
    assert_response :success
  end

  test "should create article" do
    assert_difference('Article.count') do
      post articles_url, params: { article: { code: @article.code, content: @article.content, day: @article.day, month: @article.month, published_at: @article.published_at, slug: @article.slug, string: @article.string, string: @article.string, subtitle: @article.subtitle, title: @article.title, year: @article.year } }
    end

    assert_redirected_to article_url(Article.last)
  end

  test "should show article" do
    get article_url(@article)
    assert_response :success
  end

  test "should get edit" do
    get edit_article_url(@article)
    assert_response :success
  end

  test "should update article" do
    patch article_url(@article), params: { article: { code: @article.code, content: @article.content, day: @article.day, month: @article.month, published_at: @article.published_at, slug: @article.slug, string: @article.string, string: @article.string, subtitle: @article.subtitle, title: @article.title, year: @article.year } }
    assert_redirected_to article_url(@article)
  end

  test "should destroy article" do
    assert_difference('Article.count', -1) do
      delete article_url(@article)
    end

    assert_redirected_to articles_url
  end
end
