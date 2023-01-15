defmodule PortfolioWeb.UserController do
  use PortfolioWeb, :controller

  alias Portfolio.Users
  alias Portfolio.Users.User
  alias Portfolio.Guardian

  action_fallback PortfolioWeb.FallbackController

  def index(conn, _params) do
    users = Users.list_users()
    render(conn, "index.json", users: users)
  end

  def create(conn, params) do
    with {:ok, %User{} = user} <- Users.create_user(params),
         {:ok, token, _claims} <- Guardian.encode_and_sign(user) do
      conn |> render("jwt.json", jwt: token)
    end
  end

  def show(conn, %{"id" => id}) do
    user = Users.get_user!(id)
    render(conn, "show.json", user: user)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Users.get_user!(id)

    with {:ok, %User{} = user} <- Users.update_user(user, user_params) do
      render(conn, "show.json", user: user)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Users.get_user!(id)

    with {:ok, %User{}} <- Users.delete_user(user) do
      send_resp(conn, :no_content, "")
    end
  end
end
