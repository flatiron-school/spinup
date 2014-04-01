class DropletsController < ApplicationController
  def new
    @github = GitHubConnection.new(session['github'])
  end
end
