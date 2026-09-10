# Overview
Rate limiting is a technique that allows a service to control the consumption of resources used by an instance of an application, an individual tenant, or an entire service.

## Why do Applications Rate Limit
* Protection against DDOS
* Server Stability and Consistency
* Cost Control: Mainly for subscription based SaaS.

## How do Applications Rate Limit
### Fixed Window
fixed requests per window based on time period. If the user goes past the allocated requests before the window ends, then they are throttled.

### Sliding Window
Limit based on request per second, in a sliding window of 50 requests, throttled or not.


### Token Bucket
Start with an empty container of "tokens," essentially representing requests. Fill this container up with x amount of "tokens" by second.

If bucket is empty, requests are throttled. However, if the bucket has "tokens," consume 1 token for every request.
**Burst:** If the bucket is full, the application can serve a flurry of requests.
**Sustained:** Requests are replenished by a certain amount, so at least x amount of requests can be made per second.

# Throttling
A specific way servers can handle users that go past the rate limits.
