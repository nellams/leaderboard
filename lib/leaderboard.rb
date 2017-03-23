require_relative 'team'

GAME_INFO = [
    {
      home_team: "Patriots",
      away_team: "Broncos",
      home_score: 17,
      away_score: 13
    },
    {
      home_team: "Broncos",
      away_team: "Colts",
      home_score: 24,
      away_score: 7
    },
    {
      home_team: "Patriots",
      away_team: "Colts",
      home_score: 21,
      away_score: 17
    },
    {
      home_team: "Broncos",
      away_team: "Steelers",
      home_score: 11,
      away_score: 27
    },
    {
      home_team: "Steelers",
      away_team: "Patriots",
      home_score: 24,
      away_score: 31
    }
]

class Leaderboard

  attr_reader :teams, :rank_teams, :participating_teams

  def initialize(game_info)
    @game_info = GAME_INFO
    @teams = []
    @participating_teams = []
    GAME_INFO.each do |game|
        team = @teams.find { |a| a.name == game[:home_team] }
        if team.nil?
          team = Team.new(game[:home_team])
          @teams << team
        end
        more_teams = @teams.find { |a| a.name == game[:away_team] }
        if more_teams.nil?
          more_teams = Team.new(game[:away_team])
          @teams << more_teams
        end
    end
    @teams.each do |team|
    @participating_teams << team.name
    end
  end


  def add_wins
    GAME_INFO.each do |game|
        team = @teams.find { |a| a.name == game[:home_team] }
          if game[:home_score] > game[:away_score]
            team.wins += 1
          else
            team.losses += 1
          end
        other_team = @teams.find { |a| a.name == game[:away_team] }
          if game[:away_score] > game[:home_score]
            other_team.wins += 1
          else
            other_team.losses += 1
          end
    end
    @teams.each_with_index do |hash, index|
      hash.rank = (hash.wins) - (hash.losses)
    end
    @teams = (@teams.sort_by { |team| team.rank }).reverse
  end

  def rank_teams
    @teams.each_with_index do |hash, index|
      hash.rank = index + 1
    end
    @rank_teams = @teams
  end

  def display
    @display = "--------------------------------------------------\n"
    @display += "| Name      Rank      Total Wins    Total Losses |\n"
    @teams.each do |team|
      @display += "| #{team.name.ljust(10)} #{team.rank}         #{team.wins}             #{team.losses}           |\n"
    end
    @display += "--------------------------------------------------\n"
    return @display
  end
end
