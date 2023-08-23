/*
 Ex: insert
    :eventType = 'ACCOUNT_TO_ACCOUNT'
    :actsOn    = '{"Account1", "Account2"}'
 */

INSERT INTO event_queue(event_type, status, data, acts_on, prereqs)
SELECT :eventType as event_type,
       'WAITING' as status,
       '{"comment": "metadata can go here"}'::jsonb as data,
       :actsOn as acts_on,
       COALESCE(array_agg(id), '{}') as prereqs
FROM event_queue
WHERE status IN ('WAITING', 'PROCESSING', 'POST_PROCESSING')
  AND acts_on && :actsOn

