# get PR details from incoming approve webhook
# quit if all approvers have not approved
# look for ticket ID in branch name
# look up ticket for any other unapproved PRs (if not possible thru Jira API, use bitbucket API - will have to spread across every repo in the team, though!) - quit if any
# make a request to an AfJ webhook to transition ticket from Code Review to Code Review Passed
  # bonus: work out which jira user should be the actor of the transition change (if that's possible) OR just set a custom field to the user - if we can find them based on the bitbucket user, that is

from flask import Flask, request
from os import getenv

app = Flask(__name__)

@app.route('/', methods=['POST'])
def handle_webhook():
    payload = request.get_json()
    return 'Hello, world! I don\'t do a lot just yet.'
