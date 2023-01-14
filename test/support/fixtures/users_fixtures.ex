defmodule Portfolio.UsersFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Portfolio.Users` context.
  """

  @doc """
  Generate a user.
  """
  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(%{
        active: true,
        email: "some email",
        name: "some name",
        password: "some password",
        role: "some role",
        user_name: "some user_name"
      })
      |> Portfolio.Users.create_user()

    user
  end
end
