defmodule Portfolio.PostsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Portfolio.Posts` context.
  """

  @doc """
  Generate a post.
  """
  def post_fixture(attrs \\ %{}) do
    {:ok, post} =
      attrs
      |> Enum.into(%{
        content: "some content",
        dislikes: 42,
        excerpt: "some excerpt",
        likes: 42,
        title: "some title"
      })
      |> Portfolio.Posts.create_post()

    post
  end
end
