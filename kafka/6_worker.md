## Many workers listen to topic_ready_to_process

- Gets t1 that was just produced

- Runs sync logic

- Then produces back to topic_ledger_events
  {id: t1, from: "account_1" to: "account_2", amount: 100, status: "done"}
  
- Tables get re-built with t1 removed, which allows t2 to get sent to topic_ready_to_process
  {id: t2, from: "account_1" to: "account_3", amount: 100, status: "waiting"}