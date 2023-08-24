topic_ledger_events
  .filter(l -> l.status.equals("waiting"))
  .toTable()

| instrument | waiting_transactions                       |
|------------|--------------------------------------------|
| t1         | {from: "account_1", to: "account_2", ... } |
| t2         | {from: "account_1", to: "account_3", ... } |