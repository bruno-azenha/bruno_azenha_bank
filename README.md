# Queries

The app that should be started is the `bank_poncho`. Inside you can see the configuration folders.
Change The ecto configs for the dev database to whatever postgres db suits you.

from inside the `bank_poncho` folder:

```
mix deps.get
mix ecto.create
mix ecto.migrate
mix run priv/repo/seeds.exs
mix phx.server
```

It will seed the database with the following accounts:

Avengers account ids:

"df702942-12ad-4bd5-aaf8-c24d10c26e26" => avenger_bank_account_id
"fb7b25b8-f03f-43a8-9c9a-253ac99f9454" => thor_id
"2175d194-5e45-448e-880d-bbdf9b2bbb5d" => iron_man_id
"6e1bc5af-266f-4e17-857f-0e7b048448db" => captain_america_id
"2a6a72f0-5235-4f90-a17a-3373e36e81c4" => black_widow_id
"55eb7ead-a349-4f15-a290-308b7cefacbc" => the_hulk_id
"327dd280-ad95-4fba-bb13-8ffa91c953b6" => hawkeye_id

## Create Account

Returns the Account Summary for the newly created account.
Unsurprisingly, it has zero balance and no transactions

You should store the id somewhere for the money transfer queries

```
curl --header "Content-Type: application/json" --request POST --data '{}' http://localhost:4000/api/accounts
```

## Make Money Transfers

```
<DATA> = {
    "sender_id": "<SENDER_ID>",
    "receiver_id": "<RECEIVER_ID>",
    "amount": "<SOME_INTEGER_NUMBER>" 
}

curl --header "Content-Type: application/json" --request POST --data '{"sender_id": "<SENDER_ID>", "receiver_id": "<RECEIVER_ID>", "amount": "<SOME_INTEGER_NUMBER>" }' http://localhost:4000/api/transactions
```

## Account Summary

```
curl --header "Content-Type: application/json" --request GET http://localhost:4000/api/accounts/<ACCOUNT_ID>
```

```
{
    "account_summary": {
        "balance":0,
        "id":"990863fd-6eee-4977-bd41-8d04b8451821",
        "transactions":[]
    }
}

```