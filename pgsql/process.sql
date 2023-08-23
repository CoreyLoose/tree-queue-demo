START TRANSACTION;

/**
 * THIS QUERY MUST BE RUN IN A TRANSACTION OR YOU WILL HAVE A BAD TIME.
 * - Committing the transaction is claiming that the events that you got were processed properly
 * - Rolling back the transaction puts the events back in the queue for someone else
 *
 * The magic here is FOR UPDATE SKIP LOCKED it means that if run in a transaction this query
 * will lock all rows it returns, while simultaneously ignoring any rows that have been locked
 * by other transactions. If you want to read more about this a good place to start is this blog
 * post: https://www.crunchydata.com/blog/message-queuing-using-native-postgresql
 */
WITH updated_events AS (
    UPDATE event_queue
        SET status = 'PROCESSING'
        WHERE id IN (
            SELECT id
            FROM event_queue eq
            WHERE eq.status = 'WAITING'
              AND (eq.prereqs = '{}' OR
                   0 = (SELECT count(eq_pre.*)
                        FROM event_queue eq_pre
                        WHERE eq_pre.status != 'FINISHED' AND eq_pre.id = ANY(eq.prereqs)
                   )
                )
            ORDER BY created_at FOR UPDATE SKIP LOCKED)
        RETURNING *)
SELECT * FROM updated_events ORDER BY created_at;


UPDATE event_queue SET status = 'FINISHED' WHERE id IN (5);

COMMIT;