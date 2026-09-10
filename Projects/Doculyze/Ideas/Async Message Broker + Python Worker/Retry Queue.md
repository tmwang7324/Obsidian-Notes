# Overview
This note serves to document the functionalities and edge cases of the retry queue.

## Rerun
So, if an *ingest* worker process dies mid job due to OOM kill, SIGKILL, hardware fault, or node eviction, the document  is stuck at "processing" and the message is unACKed.

**Why?** Because RabbitMQ's TCP connection lifecycle does it automatically. RabbitMQ detects the closed connection (or the heartbeat stops), and because the channel was configured with ***auto_ack=False*** (manual ack) and ***prefetch_count=1***,
any delivery never ACKed gets returned to the queue and redelivered to the next available customer.

**AMQP 0-9-1 basic.consume with no-ack=false** protocol guarantee.


