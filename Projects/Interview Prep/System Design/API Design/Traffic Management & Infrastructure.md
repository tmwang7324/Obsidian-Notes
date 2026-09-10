# Overview
***Traffic Management & Infrastructure*** is one of the target areas for optimizing API endpoints — controlling how requests reach your services and protecting them once they arrive.

## Deploy an API Gateway
- Centralize routing, authentication, and cross-cutting concerns (Kong, Zuplo, AWS API Gateway) instead of duplicating that logic in every microservice.
- Single place to apply rate limiting, auth, request/response transformation, and observability.
- Tradeoff: introduces a shared dependency / potential bottleneck if not scaled with the rest of the system.

## Rate Limiting and Throttling
- Guards infrastructure against abuse, denial-of-service attempts, and poorly written client loops.
- **Token bucket** — tokens refill at a fixed rate; a request consumes a token, allowing bursts up to the bucket size.
- **Sliding window** — counts requests in a rolling time window; smoother than fixed windows, avoids the "burst at window boundary" problem.
- Typically enforced at the gateway/load-balancer layer so individual services don't each reimplement it — see [[(C) Rate Limiter]] for a full design deep-dive.
- **In interviews:** name the algorithm (token bucket vs sliding window) and *where* it's enforced — that's usually what's being tested.

## Key Tradeoffs

| Decision | Tradeoff |
|---|---|
| API gateway vs per-service logic | Centralized consistency vs single point of failure/bottleneck |
| Token bucket vs sliding window | Allows bursts vs smoother, stricter enforcement |
| Strict limits vs generous limits | Infra protection vs developer/client experience |

## When It Comes Up
- Any public-facing API question — "how do you stop one client from taking down the service?"
- Pairs with [[(C) Load Balancing]] for how traffic is distributed before it ever reaches rate limiting.
