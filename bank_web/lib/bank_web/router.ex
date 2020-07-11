defmodule BankWeb.Router do
  use BankWeb, :router

  pipeline :api do
    plug(:accepts, ["json"])
  end

  scope "/api", BankWeb do
    post("/accounts", BankController, :create)
    pipe_through(:api)
  end
end
