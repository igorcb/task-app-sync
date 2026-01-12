class UserSyncService
  include HTTParty
  base_uri "https://jsonplaceholder.typicode.com"

  def self.fetch_user(user_id = 1)
    response = get("/users/#{user_id}")

    if response.success?
      parse_user_data(response)
    else
      { error: "Failed to fetch user data" }
    end
  rescue StandardError => e
    { error: e.message }
  end

  private

  def self.parse_user_data(response)
    user_data = response.parsed_response

    {
      name: user_data["name"],
      company: user_data.dig("company", "name"),
      city: user_data.dig("address", "city")
    }
  end
end
