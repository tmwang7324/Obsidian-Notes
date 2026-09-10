# Practicing Tradeoff Thinking

How to practice the reasoning that separates "defensive-looking code" from actually robust systems. Grounded in a real case: a retry loop added around DocuLyze's RabbitMQ confirmed publish that *weakened* the design — it reused a dead channel (couldn't fix the failure it targeted), retried unknown-outcome timeouts (duplicate risk), and tripled worst-case latency inside a user request (5s → 15s).

The recorded design decision (one-shot, swallow-and-log, sweep reconciles) was already correct — the reasoning existed, but new code wasn't checked against it.

## The procedural fix

When touching code near a recorded decision (grill doc, ADR, ledger comment), **re-read the decision and ask: does this change still honor it?** The retry loop directly contradicted the comment sitting above it. Contradictions like that are catchable mechanically, without any cleverness.

## The four reasoning moves (drills)

### 1. Enumerate failure modes concretely, not abstractly

Vague robustness ("errors can happen, so retry") collapses when you list actual triggers and their likelihood. The pivotal question was "when would the broker actually nack?" — the answer (queue process crash, disk write failure; both broker-is-dying conditions) falsified the retry's value.

**Drill:** before adding any defensive mechanism, write down (a) the specific failures it defends against, (b) roughly how often each occurs, (c) what the mechanism does *in each one*. The retry failed this: its common target (dead channel) was unfixable by it, its fixable target (live-channel nack) barely exists.

### 2. Price every mechanism in invariants

Every defense protects something and costs something. The retry bought recovery-from-rare-nack; it paid with bounded-latency and at-most-once publishing.

**Drill:** for each new mechanism ask — which invariant does this protect, and which does it weaken? (Requires having stated invariants: "no record for bytes that didn't land", "ready never regresses".)

### 3. Ask "who already recovers from this?"

Systems rot when the same failure has three half-owners. The retry duplicated a responsibility the re-publish sweep already owned.

**Drill:** before adding recovery logic, name the existing owner of that failure. Only add a new owner if there isn't one, or it's demonstrably too slow.

### 4. Walk the timeline with a knife

Take a multi-step path (presign → PUT → finalize → publish → consume) and kill the process after each step. What state results? Is it visible? Who repairs it?

**Drill:** do this on paper for every new path — then occasionally for real (`docker stop rabbitmq` mid-upload) and compare prediction vs reality. The gap is where the learning is.

## Reading

- **Designing Data-Intensive Applications** (Kleppmann) — reliability + delivery-guarantee chapters; formalizes at-most-once / at-least-once / idempotent-consumer vocabulary.
- **AWS Builders' Library**, esp. Marc Brooker's *"Timeouts, retries, and backoff with jitter"* — this exact topic, from someone who operates it at scale.
- **Jepsen analyses** (aphyr) — failure-mode enumeration as a spectator sport; for later.

## Meta-point

You don't practice tradeoffs in the abstract. You make a claim ("retries make this more robust"), force yourself to name the exact scenarios, and let the enumeration falsify the claim. Grilling does this to designs before they're built; the growth edge is running the same interrogation on code *after* it's written — especially your own.

---
Related: [[Broker Errors]] · [[Ack, Nack, DLQ]] · [[RabbitMQ]]
