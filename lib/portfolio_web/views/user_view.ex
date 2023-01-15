defmodule PortfolioWeb.UserView do
  use PortfolioWeb, :view
  alias PortfolioWeb.UserView

  def render("index.json", %{users: users}) do
    %{data: render_many(users, UserView, "user.json")}
  end

  def render("show.json", %{user: user}) do
    %{data: render_one(user, UserView, "user.json")}
  end

  def render("user.json", %{user: user}) do
    %{
      id: user.id,
      name: user.name,
      user_name: user.user_name,
      email: user.email,
      active: user.active,
      role: user.role
    }
  end

  def render("jwt.json", %{jwt: jwt}) do
    %{jwt: jwt}
  end
end
