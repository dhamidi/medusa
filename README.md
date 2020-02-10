# Description

Medusa watches GitHub repositories for commits containing a certain
message and records matching commits in a database.

This codebase serves as an example for demonstrating:

* the use of dependency injection,
* primarily modelling state transitions (`Actions`) instead of state (`Models`)

# Operation

Medusa makes network requests to GitHub's REST API and writes to a single file: `production.pstore`

The ports used for the web frontend can be configured through command
line options passed to sinatra when starting the web app.

# Tests

You can run the unit tests with `bundle exec rake spec:unit`

You can run the integration tests with `bundle exec rake spec:integration`.  These tests require a working internet connection.

# Structure

The directory `web` contains the sinatra-based web UI for the application.

You can run it with: `bundle exec ruby -Ilib web/app.rb`

## lib/medusa

This directory and its subdirectories contain the business logic.

There are five types of "things" you can find here:

* `Actions` modify persistent data and reflect user intent,
* `Queries` retrieve data from any data source. The are used by the web UI and internally by actions or other queries.
* `Types` are types for use with `ActiveModel::Attributes`.  They describe what data the application accepts.
* `Models` represent the entities the application is dealing with.
* `Adapters` (found in the `external` directory) are the bridge to the outside world.  They are concrete implementations of the interfaces actions and queries depend on.

Business logic is written to depend only on abstractions, e.g. the when reading/writing data queries and actions only operate on a key-value store that needs to support a few operations.

This allows us to use two sets of implementations for these abstractions: a fast one for the tests and a slow but complete one to interface with external systems like GitHub.

Furthermore since we are not dealing with concrete things, we can also write our tests only referring to these abstractions.

The same test suite can run unit tests (using fast adapters for interfaces) and integration tests (using the adapter that will be used in production).

## web/app.rb

This is a standard sinatra app.  The only notable thing here is that *request handlers only do one of two things*:

* either fetch data through a query and generate an HTML reponse,
* execute a command and redirect

# Next steps

To take this proof of concept further:

* make it a gem, so that it can be easily integrated with Ruby On Rails,
* properly namespace all constants (e.g. `Medusa::WatchRepositoryAction`),
* validate parameters more strictly in actions

