class GitHubConnection
  attr_reader :uid, :email, :token, :connection

  def initialize(github_data)
    @uid   = github_data["uid"]
    @email = github_data["email"]
    @token = github_data["token"]
  end

  def organizations
    connection.orgs.list.map {|org| org.login}
  end

  def teams_for(organization)
  end
end

# ORGS
# request = Typhoeus::Request.new("https://api.github.com/user/orgs", headers: {Authorization: "token #{@token}"})
# response = request.run
# orgs = JSON.parse(response.body)
# key: ["login"]

# TEAMS
# request = Typhoeus::Request.new("https://api.github.com/orgs/:org_name/teams", headers: {Authorization: "token #{@token}"})
# response = request.run
# teams = JSON.parse(response.body)
# key: ["name"] & ["id"]

# MEMBERS
# request = Typhoeus::Request.new("https://api.github.com/teams/:team_id/members", headers: {Authorization: "token #{@token}"})
# response = request.run
# members = JSON.parse(response.body)
# key: ["login"] & ["id"]

# PUBLIC KEYS
# request = request = Typhoeus::Request.new("https://api.github.com/users/:user_name/keys")
# reponse = request.run
# keys = JSON.parse(response.body)
# key: ["id"] & ["key"]