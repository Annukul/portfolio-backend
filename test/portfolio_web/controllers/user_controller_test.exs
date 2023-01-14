defmodule PortfolioWeb.UserControllerTest do
  use PortfolioWeb.ConnCase

  import Portfolio.UsersFixtures

  alias Portfolio.Users.User

  @create_attrs %{
    active: true,
    email: "some email",
    name: "some name",
    password: "some password",
    role: "some role",
    user_name: "some user_name"
  }
  @update_attrs %{
    active: false,
    email: "some updated email",
    name: "some updated name",
    password: "some updated password",
    role: "some updated role",
    user_name: "some updated user_name"
  }
  @invalid_attrs %{active: nil, email: nil, name: nil, password: nil, role: nil, user_name: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all users", %{conn: conn} do
      conn = get(conn, Routes.user_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create user" do
    test "renders user when data is valid", %{conn: conn} do
      conn = post(conn, Routes.user_path(conn, :create), user: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.user_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "active" => true,
               "email" => "some email",
               "name" => "some name",
               "password" => "some password",
               "role" => "some role",
               "user_name" => "some user_name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.user_path(conn, :create), user: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update user" do
    setup [:create_user]

    test "renders user when data is valid", %{conn: conn, user: %User{id: id} = user} do
      conn = put(conn, Routes.user_path(conn, :update, user), user: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.user_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "active" => false,
               "email" => "some updated email",
               "name" => "some updated name",
               "password" => "some updated password",
               "role" => "some updated role",
               "user_name" => "some updated user_name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, user: user} do
      conn = put(conn, Routes.user_path(conn, :update, user), user: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete user" do
    setup [:create_user]

    test "deletes chosen user", %{conn: conn, user: user} do
      conn = delete(conn, Routes.user_path(conn, :delete, user))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.user_path(conn, :show, user))
      end
    end
  end

  defp create_user(_) do
    user = user_fixture()
    %{user: user}
  end
end
