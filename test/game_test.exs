defmodule ExMon.GameTest do
  use ExUnit.Case

  alias ExMon.{Game, Player}

  describe "start/2" do
    test "starts the game state" do
      player = Player.build("Ana", :chute, :soco, :cura)
      computer = Player.build("Robotnik", :chute, :soco, :cura)

      assert {:ok, _pid} = Game.start(computer, player)
    end
  end

  describe "info/0" do
    test "returns the current game state" do
      player = Player.build("Ana", :chute, :soco, :cura)
      computer = Player.build("Robotnik", :chute, :soco, :cura)

      Game.start(computer, player)

      expected_response = %{
        status: :started,
        player: %Player{
          life: 100,
          moves: %{move_avg: :soco, move_heal: :cura, move_rnd: :chute},
          name: "Ana"
        },
        computer: %Player{
          life: 100,
          moves: %{move_avg: :soco, move_heal: :cura, move_rnd: :chute},
          name: "Robotnik"
        },
        turn: :player
      }

      assert expected_response == Game.info()
    end
  end

  describe "update/1" do
    test "return the game updated" do
      player = Player.build("Ana", :chute, :soco, :cura)
      computer = Player.build("Robotnik", :chute, :soco, :cura)

      Game.start(computer, player)

      expected_response = %{
        status: :started,
        player: %Player{
          life: 100,
          moves: %{move_avg: :soco, move_heal: :cura, move_rnd: :chute},
          name: "Ana"
        },
        computer: %Player{
          life: 100,
          moves: %{move_avg: :soco, move_heal: :cura, move_rnd: :chute},
          name: "Robotnik"
        },
        turn: :player
      }

      assert expected_response == Game.info()

      new_state = %{
        status: :started,
        player: %Player{
          life: 85,
          moves: %{move_avg: :soco, move_heal: :cura, move_rnd: :chute},
          name: "Ana"
        },
        computer: %Player{
          life: 50,
          moves: %{move_avg: :soco, move_heal: :cura, move_rnd: :chute},
          name: "Robotnik"
        },
        turn: :player
      }

      Game.update(new_state)

      expected_response = %{new_state | turn: :computer, status: :continue}

      assert expected_response == Game.info()
    end
  end

  describe "player/0" do
    test "gets player info" do
      player = Player.build("Ana", :chute, :soco, :cura)
      computer = Player.build("Robotnik", :chute, :soco, :cura)

      Game.start(computer, player)

      expected_response = %Player{
        life: 100,
        moves: %{move_avg: :soco, move_heal: :cura, move_rnd: :chute},
        name: "Ana"
      }

      assert expected_response == Game.player()
    end
  end

  describe "turn/0" do
    test "gets turn info" do
      player = Player.build("Ana", :chute, :soco, :cura)
      computer = Player.build("Robotnik", :chute, :soco, :cura)

      Game.start(computer, player)

      assert :player == Game.turn()
    end
  end
end
