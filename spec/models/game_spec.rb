require "rails_helper"

RSpec.describe Game, type: :model do
  let(:blank){"can't be blank"}
  let(:not_number){"is not a number"}
  let(:not_integer){"must be an integer"}
  let(:less_than_zero){"must be greater than 0"}

  describe "create a game without status param" do
    let(:game){Game.create player_count: player, deck_count: deck}

    context "with blank paramters" do
      let(:player){""}
      let(:deck){nil}
      it{expect(game.errors[:player_count]).to eq [blank, not_number]}
      it{expect(game.errors[:deck_count]).to eq [blank, not_number]}
    end

    context "with non-integer" do
      let(:player){"foo"}
      let(:deck){[]}
      it{expect(game.errors[:player_count]).to eq [not_number]}
      it{expect(game.errors[:deck_count]).to eq [blank, not_number]}
    end

    context "with non positive numbers" do
      let(:player){-1}
      let(:deck){0}
      it{expect(game.errors[:player_count]).to eq [less_than_zero]}
      it{expect(game.errors[:deck_count]).to eq [less_than_zero]}
    end

    context "with non-integer numbers" do
      let(:player){1.1}
      let(:deck){Math::PI}
      it{expect(game.errors[:player_count]).to eq [not_integer]}
      it{expect(game.errors[:deck_count]).to eq [not_integer]}
    end

    context "with valid paramters" do
      let(:player){1}
      let(:deck){3}
      let(:created_game){Game.first}
      it{expect(game).to eq created_game}
      it{expect(game.status).to eq "active"}
    end
  end

  describe "create a game with status param" do
    let(:game) do
      Game.create player_count: player, deck_count: deck, status: status
    end

    context "with status out of enum values" do
      let(:player){1}
      let(:deck){2}
      let(:status){2}
      it{expect{game.errors[:status]}.to raise_error ArgumentError}
    end

    context "with valid paramters" do
      let(:player){1}
      let(:deck){3}
      let(:status){"inactive"}
      let(:created_game){Game.first}
      it{expect(game).to eq created_game}
      it{expect(game.status).to eq status}
    end
  end
end
