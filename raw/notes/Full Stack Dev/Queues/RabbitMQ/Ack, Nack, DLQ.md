# Overview
`basic.ack`, short for **Acknowledged**, is the protocol method that represents a *positive acknowledgement.* This instructs RabbitMQ that the envelope has successfully been delivered and can be discarded.
`basic.nack` is the protocol method that represents a *negative acknowledgement,* essentially alerting failure. The envelope is either requeued or sent to the dead queue.
`basic.reject`

```python

```

### Ack

### Nack
RabbitMQ only sends a publisher `basic.nack` when it *cannot take responsibility* for the message. The concrete triggers:
* **Internal error in the queue process** - the Erlang process backing `doc.ingest` crashes before the message is persisted. The broker nacks everything in flight to the queue.
* **Persistence failure** - the disk write for a persistent message fails (I/O error, disk full at the OS level).
* **Queue overflow with `overflow: reject-publish`** - a queue declared with `x-max-length` and that overflow policy nacks new publishes when full. I don't set either on `doc.ingest`, and the default (`drop-head`) *acks* the publish after evicting old messages, so this path doesn't exist for you.
* **Node failure** hosting the queue (relevant for clustered/quorum setups; my single-node docker broker just becomes a dropped connection instead).
*
## Customer Acknolwedgement Modes and Data Safety Considerations
When a node delivers a message to a consumer, it has to decide whether the message should be considered handled (or at least received) by the consumer. Since multiple **data transfer schemes** can fail (client connections, consumer apps, and so on), the decision is a data safety concern.

Depending on the **acknowledgement mode** used, RabbitMQ can consider a message to be successfully delivered either immediate22


