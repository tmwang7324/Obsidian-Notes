# Overview
Instead of using a plain RabbitMQ channel, I used a confirm channel `createConfirmChannel()`. 

## Confirm Channel
The `sendToQueue()` function for a confirm channel in RabbitMQ only fires a callback once the broker itself has acknowledged that a persistent message landed on the durable queue.

A plain channel returns a boolean about whether a local write buffer accepted the write. It doesn't say tell me whether the write actually succeeded.