class GitHubConnection
  attr_reader :token, :username

  def initialize(github_data)
    @username = github_data["username"]
    @token = github_data["token"]
  end

  def organizations
    @organizations ||= get_organizations
  end

  def get_organizations
    request = Typhoeus::Request.new(
      "https://api.github.com/user/orgs",
      headers: {Authorization: "token #{self.token}"}
    )
    response = request.run
    orgs = JSON.parse(response.body).map {|org| org["login"]}
  end

  def teams_for(organization)
    instance_variable_get("@teams_for_#{normalize_org_name(organization)}") ?
      instance_variable_get("@teams_for_#{normalize_org_name(organization)}") :
      get_teams_for(organization)
  end

  def get_teams_for(organization)
    request = Typhoeus::Request.new(
      "https://api.github.com/orgs/#{githubify_org_name(organization)}/teams",
      headers: {Authorization: "token #{self.token}"}
    )
    response = request.run
    teams = JSON.parse(response.body).inject({}) do |memo, team|
      memo[team["name"]] = team["id"]
      memo
    end

    instance_variable_set("@teams_for_#{normalize_org_name(organization)}", teams)
  end

  def normalize_org_name(org)
    org.gsub('-','_')
  end

  def githubify_org_name(org)
    org.gsub('_','-')
  end

  def members_of(team)
    
  end
end

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