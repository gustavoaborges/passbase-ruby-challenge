# Virtual Bank

Implements Passbase code challenge.

## How it works

The user balance is the result of analyzing their transaction history, as if its an event-source datastore with only one type of event. User balance is grouped by currency, just to make things easier. For simplicity sake, an user can only transfer from one currency balance, even if it has to be converted to the target currency. A transaction is a state machine that starts as `requested` and that will block funds from user while they are not processed.

Currency convertion rates are hard-coded into configuration initializer, but its performed by a service class that can be reimplemented, preserving its contract, to use an external source.

## How to use

```bash
docker-compose up -d --build
```