# Bitbucket Approvals to Jira

**NOTE:** This repo is under construction. Nothing here works as advertised, yet!

Links [Bitbucket Cloud](https://bitbucket.org) and
[Jira Software Server](https://www.atlassian.com/software/jira/download) together so that PR approvals can trigger
ticket workflows (when you include a ticket ID in your branch name!). Requires the
[Automation for Jira](https://marketplace.atlassian.com/apps/1215460/automation-for-jira-server) app.

Tested with Jira 8.1.0 and Automation for Jira 5.2.14. Your mileage may vary on other versions!

## Contents

- [Bitbucket Approvals to Jira](#bitbucket-approvals-to-jira)
  - [Contents](#contents)
  - [Setting up Bitbucket](#setting-up-bitbucket)
  - [Setting up Jira](#setting-up-jira)
  - [Deploying in production](#deploying-in-production)
  - [Running locally](#running-locally)
  - [Receiving webhooks locally](#receiving-webhooks-locally)
  - [Contributing](#contributing)

## Setting up Bitbucket

From your repository's home page:

1. Go to _Repository settings_ in the left menu
1. Click _Webhooks_
1. Click _Add webhook_
1. Provide a title, and the URL where your deployment is available  
   <sub><sup>(see [Deploying in production](#deploying-in-production) or
   [Receiving webhooks locally](#receiving-webhooks-locally) below)</sup></sub>
1. If you're developing, testing or otherwise debugging the app, check _Enable request history collection_  
   <sub><sup>(this will help you if anything goes wrong by recording the full payloads at Bitbucket, and allowing you to
   easily resend them)</sup></sub>
1. Next to _Triggers_, select _Choose from a list of triggers_
1. Deselect _Push_ and select just _Approved_, under _Pull Request_
1. Click _Save_
1. Once you've also set up Jira, create a branch with a Jira ticket ID in it, get the ticket to the right state for a
code review, create a PR, approve it, and watch the ticket transition!

## Setting up Jira

Coming soon...

## Deploying in production

You can host this anywhere you can run Python & receive incoming HTTPS pings.

If you're looking for somewhere, I recommend Heroku. It works great for small apps and will be free for most use cases.

More details coming soon...

## Running locally

Setup a simple [virtualenv](https://docs.python.org/3/library/venv.html) and install dependencies:

    make setup
    make install

Run the app in development mode:

    make run

With the configuration baked into the [Makefile](Makefile), Flask's built-in server will automatically restart as you
make changes to the code. This makes development easier.

As noted in the Flask documentation though, this server should **not** be used in production.

To trigger the app while it's running:

    curl localhost:5000

or visit http://localhost:5000 in your browser.

Lint, test, or view coverage reports in your browser:

    make lint
    make test
    make coverage

Clean up the virtualenv:

    make clean

## Receiving webhooks locally

To develop locally, at some point you might need a test repo to send real webhooks to you.

There are multiple ways to expose your local environment online, but I like to use [ngrok](https://ngrok.com).

Download the app and follow its instructions to set up and link to your account, then in a separate terminal window run:

    ./ngrok http 5000

You can then provide Bitbucket with your ngrok URL (eg. https://d123456ab7c8.ngrok.io), and it'll route straight through
to your locally running app. This gives you HTTPS for free, too!

## Contributing

Issues and pull requests welcome. If adding any custom functionality, please consider gating it behind an environment
variable so it isn't enabled by default.
