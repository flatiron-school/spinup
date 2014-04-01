class DropletsController < ApplicationController
  def new
    @github = GitHubConnection.new(session['github'])
    binding.pry
  end
end
