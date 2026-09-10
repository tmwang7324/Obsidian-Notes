# Overview
The main idea behind Work Queues (aka: *Task Queues*) is to avoid doing a resource-intensive task immediately and having to wiat for it to complete. Queues store messages, which are encapsulated tasks, with *routing keys.*

**IMPORTANT:** Whatever is done on the consumer side **MUST** be done for the Producer.

## Message Durability
When RabbitMQ quits or crashes it will forget the queues and a messages unless I tell it not to. Two things are required to make sure that messages aren't lost: I need to mark both the **queue** and the messages as *durable.*

#### Queue
```python
channel.queue_declare(queue='hello', durable=True, arguments= {'x-dead-letter-exchange': ""} )
```
#### Messages
```python
channel.basic_publish(exchange='DLX',
routing_key='hello',
body=message,
properties=pika.BasicProperties(
	delivery_mode = pika.DeliveryMode.Persistent
))
```


## x-dead-letter-exchange
The `x-dead-letter-exchange` argument in `queue_declare` specifies where dead letters, messages that return `nack` or expire past **TTL** go.

The `x-dead-letter-routing-key` argument specifies which queue dead letters should route to.

**IMPORTANT:** if the `x-dead-letter-exchange` is set to "", then the **DLX** is set to the **default exchange.** 
The empty string is the reserved name of RabbitMQ's built-in nameless exchange --- it always exists, I can't delete it. 
Furthermore, it is a direct exchange with an implicit binding to *every* queue using the queue's own name as the routing key. Thus, the `x-letter-routing-key` can reference any queue across every exchange.

```python
queue.create
```