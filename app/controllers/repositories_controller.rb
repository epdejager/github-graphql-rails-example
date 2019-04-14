class RepositoriesController < ApplicationController
  # Define query for repository listing.
  #
  # All queries MUST be assigned to constants and therefore be statically
  # defined. Queries MUST NOT be generated at request time.
  IndexQuery = GitHub::Client.parse <<-'GRAPHQL'
    # All read requests are defined in a "query" operation
    query {
      # viewer is the currently authenticated User
        courses{
          ...Views::Repositories::Index::Course
        }
    }
  GRAPHQL

  # GET /repositories
  def index
    # Use query helper defined in ApplicationController to execute the query.
    # `query` returns a GraphQL::Client::QueryResult instance with accessors
    # that map to the query structure.
    data = query IndexQuery

    # Render the app/views/repositories/index.html.erb template with our
    # current User.
    #
    # Using explicit render calls with locals is preferred to implicit render
    # with instance variables.
    render "repositories/index", locals: {
      courses: data.courses
    }
  end
end