module Sinatra
  module Auth
    module Github
      module Helpers
        # Like the native github_team_authenticate! but accepts an array of team ids
        def github_teams_authenticate!(teams)
          authenticate!
          halt([401, 'Unauthorized User']) unless teams.any? { |team_id| github_team_access?(team_id) }
        end

        def fine_teams_authenticate!(team_whitelists)
          authenticate!
          halt([401, 'Unauthorized User']) unless team_whitelists
            .any? { |team_id, whitelist| github_team_access?(team_id) && whitelist.match(request.path_info) }
        end
      end
    end
  end
end
