require_relative '../player'

describe Player do
  describe 'initialize' do
    it "sets @icon to the given parameter" do
      player = Player.new('X')
      expect(player.icon).to eq('X')
    end
  end
end
