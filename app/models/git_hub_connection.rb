class GitHubConnection
  attr_reader :token, :username, :orgs, :members

  def initialize(github_data)
    @username = github_data["username"]
    @token = github_data["token"]
    @orgs = {}
    @members = {}
  end

  def organizations
    @organizations ||= get_organizations
  end

  def get_organizations
    request = Typhoeus::Request.new(
      "https://api.github.com/user/orgs",
      headers: {Authorization: "token #{token}"}
    )
    response = request.run
    orgs = JSON.parse(response.body).map {|org| org["login"]}
  end

  def teams_for(organization)
    orgs[organization.to_sym] ||= get_teams_for(organization)
  end

  def get_teams_for(organization)
    request = Typhoeus::Request.new(
      "https://api.github.com/orgs/#{organization}/teams",
      headers: {Authorization: "token #{token}"}
    )
    response = request.run
    teams = JSON.parse(response.body).inject([]) do |memo, team|
      memo << {id: team["id"], name: team["name"]}
      memo
    end
  end

  def members_of(team)
    members[team[:id]] ||= get_members_of(team)
  end

  def get_members_of(team)
    id = team[:id]
    request = Typhoeus::Request.new(
      "https://api.github.com/teams/#{id}/members",
      headers: {Authorization: "token #{token}"}
    )
    response = request.run
    members = JSON.parse(response.body).inject([]) do |memo, member|
      memo << {id: member["id"], username: member["login"]}
      memo
    end
  end

  def public_keys_for(team)
    members = members_of(team)
    members.map do |member|
      {
        username: member[:username],
        key: public_key_for_user(member)
      }
    end
  end

  def public_key_for_user(user)
    request = Typhoeus::Request.new(
      "https://api.github.com/users/#{user[:username]}/keys",
      params: {client_id: ENV['GITHUB_ID'], client_secret: ENV['GITHUB_SECRET']}
    )
    response = request.run
    key = JSON.parse(response.body).first
  end
end