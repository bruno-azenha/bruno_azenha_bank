defmodule BankWeb.Router do
  use BankWeb, :router

  pipeline :api do
    plug(:accepts, ["json"])
  end

  scope "/api", BankWeb do
    get("/accounts/:id", AccountsController, :show)
    post("/accounts", AccountsController, :create)
    post("/transactions", TransactionsController, :create)
    pipe_through(:api)
  end
end
