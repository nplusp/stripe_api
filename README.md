# README

## Description
Write a simple rails application that receives and processes events from Stripe.

## Acceptance criteria:
* creating a subscription on [Stripe](https://stripe.com) (via subscription UI) creates a simple subscription record in your database
* the initial state of the subscription record should be 'unpaid'
* paying the first invoice of the subscription changes the state of your local subscription record from 'unpaid' to 'paid'
* canceling a subscription changes the state of your subscription record to 'canceled'
* only subscriptions in the state 'paid' can be canceled
* the rails application should be easy to spin so it can be tested by any developer

## Out of scope:
Frontend

## Additional information:
You have to create an account on [Stripe](https://stripe.com). Accounts on Stripe are free of charge if not used for any real transactions. Upon creation your account should be in [test mode](https://stripe.com/docs/keys#test-live-modes) by default. Creating a subscription and paying the invoice can all be done in the test mode via the [Stripe Billing UI](https://dashboard.stripe.com/test/billing). To make things easy and to save time on your end, we advise you to use the UI to create subscriptions, pay the invoice and canceling subscriptions instead of using the [Stripe API](https://stripe.com/docs/api).

## Delivery:
Submit your code via a public git repository.

## Helpful links:
* [Register](https://dashboard.stripe.com/register) a free Stripe account
* [Subscription UI](https://dashboard.stripe.com/subscriptions) to create a subscription and pay the invoice
* [Stripe CLI](https://stripe.com/docs/stripe-cli) to [listen to events](https://stripe.com/docs/cli/listen) triggered by Stripe on your local machine [Stripe Webhooks](https://stripe.com/docs/billing/subscriptions/webhooks)
* expected [status codes](https://stripe.com/docs/webhooks#fix-http-status-codes) and [behavior](https://stripe.com/docs/webhooks#behaviors) of your webhook

## How to run
* Clone the repo
* Provide your Stripe Secret API key in .env file
* Run `stripe login --project-name=stripe_api` to generate Stripe config in `~/.config/stripe/config.toml`
* Copy it over to project folder: `cp -r ~/.config/stripe/ /PROJECT_FOLDER/.stripe/`
* Run `docker-compose up`
