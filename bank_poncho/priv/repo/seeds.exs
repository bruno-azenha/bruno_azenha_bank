avenger_bank_account_id = "df702942-12ad-4bd5-aaf8-c24d10c26e26"
thor_id = "fb7b25b8-f03f-43a8-9c9a-253ac99f9454"
iron_man_id = "2175d194-5e45-448e-880d-bbdf9b2bbb5d"
captain_america_id = "6e1bc5af-266f-4e17-857f-0e7b048448db"
black_widow_id = "2a6a72f0-5235-4f90-a17a-3373e36e81c4"
the_hulk_id = "55eb7ead-a349-4f15-a290-308b7cefacbc"
hawkeye_id = "327dd280-ad95-4fba-bb13-8ffa91c953b6"

:ok = BankPersistence.save_account(avenger_bank_account_id)
:ok = BankPersistence.save_account(thor_id)
:ok = BankPersistence.save_account(iron_man_id)
:ok = BankPersistence.save_account(captain_america_id)
:ok = BankPersistence.save_account(black_widow_id)
:ok = BankPersistence.save_account(the_hulk_id)
:ok = BankPersistence.save_account(hawkeye_id)

# Giving everyone money from the Avenger Bank
{:ok, _} = BankPersistence.save_transaction(avenger_bank_account_id, thor_id, 50_000)
{:ok, _} = BankPersistence.save_transaction(avenger_bank_account_id, iron_man_id, 2_000_000_000)
{:ok, _} = BankPersistence.save_transaction(avenger_bank_account_id, captain_america_id, 50_000)
{:ok, _} = BankPersistence.save_transaction(avenger_bank_account_id, black_widow_id, 20_000_000)
{:ok, _} = BankPersistence.save_transaction(avenger_bank_account_id, the_hulk_id, 10_000_000)
{:ok, _} = BankPersistence.save_transaction(avenger_bank_account_id, hawkeye_id, 1_000_000)

## Iron Man Spreading lots of his money. Great one tho see the limit of the number of transactions
{:ok, _} = BankPersistence.save_transaction(iron_man_id, captain_america_id, 10000)
{:ok, _} = BankPersistence.save_transaction(iron_man_id, the_hulk_id, 40000)
{:ok, _} = BankPersistence.save_transaction(iron_man_id, hawkeye_id, 44000)
{:ok, _} = BankPersistence.save_transaction(iron_man_id, captain_america_id, 40000)
{:ok, _} = BankPersistence.save_transaction(iron_man_id, black_widow_id, 9000)
{:ok, _} = BankPersistence.save_transaction(iron_man_id, captain_america_id, 30000)
{:ok, _} = BankPersistence.save_transaction(iron_man_id, hawkeye_id, 44000)
{:ok, _} = BankPersistence.save_transaction(iron_man_id, black_widow_id, 1_000_000)
{:ok, _} = BankPersistence.save_transaction(hawkeye_id, the_hulk_id, 44000)
{:ok, _} = BankPersistence.save_transaction(iron_man_id, captain_america_id, 20000)
{:ok, _} = BankPersistence.save_transaction(iron_man_id, hawkeye_id, 9000)
{:ok, _} = BankPersistence.save_transaction(iron_man_id, the_hulk_id, 44000)
{:ok, _} = BankPersistence.save_transaction(iron_man_id, hawkeye_id, 9000)
{:ok, _} = BankPersistence.save_transaction(iron_man_id, black_widow_id, 9000)
{:ok, _} = BankPersistence.save_transaction(iron_man_id, the_hulk_id, 40000)
{:ok, _} = BankPersistence.save_transaction(the_hulk_id, black_widow_id, 2_000)
{:ok, _} = BankPersistence.save_transaction(the_hulk_id, iron_man_id, 5000)
{:ok, _} = BankPersistence.save_transaction(the_hulk_id, iron_man_id, 1000)
{:ok, _} = BankPersistence.save_transaction(the_hulk_id, black_widow_id, 1_000_000)
{:ok, _} = BankPersistence.save_transaction(iron_man_id, black_widow_id, 1_000_000)
{:ok, _} = BankPersistence.save_transaction(iron_man_id, captain_america_id, 1_000_000)
{:ok, _} = BankPersistence.save_transaction(black_widow_id, iron_man_id, 50)
{:ok, _} = BankPersistence.save_transaction(iron_man_id, black_widow_id, 1_000_000)
{:ok, _} = BankPersistence.save_transaction(black_widow_id, captain_america_id, 1_000_000)
