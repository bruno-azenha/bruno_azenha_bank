defmodule BankWeb.FallbackController do
  use BankWeb, :controller

  def call(conn, {:error, :account_not_found}) do
    conn
    |> put_status(:not_found)
    |> json(%{error: :account_not_found})
  end

  def call(conn, {:error, :same_sender_and_receiver}) do
    conn
    |> put_status(:bad_request)
    |> json(%{error: :same_sender_and_receiver})
  end

  def call(conn, {:error, :invalid_id_format}) do
    conn
    |> put_status(:bad_request)
    |> json(%{error: "ID must be a uuid"})
  end

  def call(conn, _) do
    conn
    |> put_status(:internal_server_error)
    |> json(%{error: "Unexpected error"})
  end
end
