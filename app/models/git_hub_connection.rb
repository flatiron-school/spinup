class GitHubConnection
  attr_reader :username, :auth_header, :request_params, :orgs, :members, :base_url

  def initialize(github_data)
    @username = github_data["username"]
    @auth_header = {Authorization: "token #{github_data['token']}"}
    @request_params = {client_id: ENV['GITHUB_ID'], client_secret: ENV['GITHUB_SECRET']}
    @base_url = "https://api.github.com"
    @orgs = {}
    @members = {}
  end

  def organizations
    @organizations ||= get_organizations
  end

  def get_organizations
    request = RequestMaker.new(base_url, "/user/orgs", auth_header)
    orgs = JSON.parse(request.make_authenticated_request!).map {|org| org["login"]}
  end

  def teams_for(organization)
    orgs[organization.to_sym] ||= get_teams_for(organization)
  end

  def get_teams_for(organization)
    request = RequestMaker.new(base_url, "/orgs/#{organization}/teams", auth_header)
    teams = collect_group(
      JSON.parse(request.make_authenticated_request!),
      {id: "id", name: "name"}
    )
  end

  def members_of(team)
    members[team[:id]] ||= get_members_of(team)
  end

  def get_members_of(team)
    id = team[:id]
    request = RequestMaker.new(base_url, "/teams/#{id}/members", auth_header)
    members = collect_group(
      JSON.parse(request.make_authenticated_request!),
      {id: "id", username: "login"}
    )
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
    request = RequestMaker.new(base_url, "/users/#{user[:username]}/keys")
    key = JSON.parse(request.make_request!(request_params)).first
  end

  private

    def collect_group(collection, options)
      collection.inject([]) do |memo, item|
        individual = options.inject({}) do |hash, pair|
          hash[pair[0]] = item[pair[1]]
          hash
        end
        memo << individual
        memo
      end
    end
end