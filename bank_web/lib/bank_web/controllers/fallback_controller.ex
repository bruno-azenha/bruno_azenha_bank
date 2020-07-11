defmodule BankWeb.FallbackController do
  use BankWeb, :controller

  def call(conn, _) do
    conn
    |> put_status(:internal_server_error)
    |> json(%{error: "Unexpected error"})
  end
end
