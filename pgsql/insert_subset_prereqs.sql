/*
 Ex: insert
    :eventType        = 'EXTERNAL_ACCOUNT_TO_INTERNAL_ACCOUNT'
    :actsOn           = '{"ExternalAccount1", "Account1"}'
    :preReqEventTypes = '{}'
 */

INSERT INTO event_queue(event_type, status, data, acts_on, prereqs)
SELECT :eventType as event_type,
       'WAITING' as status,
       '{}'::jsonb as data,
       :actsOn as acts_on,
       COALESCE(array_agg(id), '{}') as prereqs
FROM event_queue
WHERE status IN ('WAITING', 'PROCESSING', 'POSTPROCESSING')
  AND acts_on && :actsOn
  AND ARRAY[event_type::varchar] && :preReqEventTypes

