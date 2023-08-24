## Left join the two tables on 
table_instrument_to_transactions.from/to => table_waiting_on_transactions.instrument

#table_instrument_to_transactions
| instrument | waiting_transactions                       |
|------------|--------------------------------------------|
| t1         | {from: "account_1", to: "account_2", ... } |
| t2         | {from: "account_1", to: "account_3", ... } |

#table_waiting_on_transactions
| instrument | waiting_transactions |
|------------|----------------------|
| account_1  | [t1, t2]             |
| account_2  | [t1]                 |
| account_3  | [t2]                 |


t1 => [[t1, t2], [t1]]
t2 => [[t1, t2], [t2]]

## Dispatch events where the key (transaction id) is first in all sub lists
- this means we can run t1 now
- but t2 has to wait because of the [t1, t2] prereq