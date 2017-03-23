require 'spec_helper'
require_relative "../../lib/team"
require_relative "../../lib/Leaderboard"
# require_relative "../../lib/display"

RSpec.describe Leaderboard do

  let(:leaderboard) { Leaderboard.new([
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
  ])}

  describe ".new" do
    it 'takes an array of hashes GAME_INFO as an argument' do
      expect(Leaderboard.new(GAME_INFO)).to be_a(Leaderboard)
    end

    it 'creates an array of Team objects for each participating team.' do
      expect(leaderboard.teams).to be_an(Array)
      expect(leaderboard.teams).to all(be_a(Team))
    end
    it 'has a reader for the list of teams' do
      expect(leaderboard.participating_teams).to eq(["Patriots", "Broncos", "Colts", "Steelers"])
    end
  end

  describe ".add_wins" do
    it 'goes through the GAME_INFO and adds each win or loss to the appropriate team in the team_list' do
      leaderboard.add_wins
      if leaderboard.teams[0].name == "Patriots"
        expect(leaderboard.teams[0].wins).to eq(3)
        expect(leaderboard.teams[0].losses).to eq(0)
      elsif leaderboard.teams[0].name == "Steelers"
        expect(leaderboard.teams[1].wins).to eq(1)
        expect(leaderboard.teams[1].losses).to eq(1)
      elsif leaderboard.teams[0].name == "Broncos"
        expect(leaderboard.teams[2].wins).to eq(1)
        expect(leaderboard.teams[2].losses).to eq(2)
      elsif leaderboard.teams[0].name == "Colts"
        expect(leaderboard.teams[3].wins).to eq(0)
        expect(leaderboard.teams[3].losses).to eq(2)
      end
    end
  end

  describe ".rank_teams" do
    it "sets each team's rank based on their wins and losses" do
      leaderboard.add_wins
      expect(leaderboard.rank_teams[0].rank).to eq(1)
    end
  end

  describe ".display" do
    it 'prints the game statistics in a reader-friendly format' do
      leaderboard.add_wins
      leaderboard.rank_teams

      expect(leaderboard.display).to eq(
     "--------------------------------------------------\n| Name      Rank      Total Wins    Total Losses |\n| Patriots   1         3             0           |\n| Steelers   2         1             1           |\n| Broncos    3         1             2           |\n| Colts      4         0             2           |\n--------------------------------------------------\n"
      )
    end
  end
end
