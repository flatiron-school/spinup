class SessionsController < ApplicationController
  
  def new
  end

  def create
    set_session_data

    if session['token']
      redirect_to new_droplets_path
    end
  end

  private
    def set_session_data
      github_data = request.env['omniauth.auth']
      session['github'] = {
        :uid => github_data.uid,
        :email => github_data.info.email,
        :token => github_data.credentials.token
      }
    end

end