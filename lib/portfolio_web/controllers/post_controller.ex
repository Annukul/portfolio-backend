defmodule PortfolioWeb.PostController do
  use PortfolioWeb, :controller

  alias Portfolio.Posts
  alias Portfolio.Posts.Post
  alias Portfolio.Guardian

  action_fallback PortfolioWeb.FallbackController

  def index(conn, _params) do
    posts = Posts.list_posts()
    render(conn, "index.json", posts: posts)
  end

  def create(conn, params) do
    user = Guardian.Plug.current_resource(conn)
    user_params = Map.put(params, "user_id", user.id)
    with {:ok, %Post{} = post} <- Posts.create_post(user_params) do
      conn
      |> put_status(:created)
      # |> put_resp_header("location", Routes.post_path(conn, :show, post))
      |> render("show.json", post: post)
    end
  end

  def show(conn, %{"id" => id}) do
    post = Posts.get_post!(id)
    render(conn, "show.json", post: post)
  end

  def update(conn, %{"id" => id} = params) do
    post = Posts.get_post!(id)
    with {:ok, %Post{} = post} <- Posts.update_post(post, params) do
      render(conn, "show.json", post: post)
    end
  end

  def delete(conn, %{"id" => id}) do
    post = Posts.get_post!(id)
    with {:ok, %Post{}} <- Posts.delete_post(post) do
      send_resp(conn, :no_content, "")
    end
  end
end
