create table event_queue
(
    id                       bigserial                     primary key,
    event_type               text                          not null,
    status                   text                          not null,
    prereqs                  bigint[]                      not null,
    acts_on                  text[]                        not null,
    data                     jsonb                         not null,
    post_processing_required jsonb     default '{}'::jsonb not null,
    created_at               timestamp default now(),
    modified_at              timestamp default now()       not null
);

create index event_queue_status_index
    on event_queue (status);
