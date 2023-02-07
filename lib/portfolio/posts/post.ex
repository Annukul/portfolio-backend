defmodule Portfolio.Posts.Post do
  use Ecto.Schema
  import Ecto.Changeset

  @derive {Jason.Encoder, only: [:title, :excerpt, :content, :likes, :dislikes, :user_id]}
  schema "posts" do
    field :content, :string
    field :dislikes, :integer, default: 0
    field :excerpt, :string
    field :likes, :integer, default: 0
    field :title, :string
    field :user_id, :id

    timestamps()
  end

  @doc false
  def changeset(post, attrs) do
    post
    |> cast(attrs, [:title, :excerpt, :content, :user_id])
    |> validate_required([:title, :content, :user_id])
    |> validate_length(:title, min: 20)
  end
end
