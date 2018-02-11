require_relative '../computer'
require_relative '../player'

describe Computer do
  computer = Computer.new('X')
  it { expect(described_class.superclass).to be Player }

  describe 'initialize' do
    it 'sets @icon to the given parameter' do
      expect(computer.icon).to eq('X')
    end
  end

  describe '#set_difficulty' do
    context 'when sending an invalid parameter value' do
      it 'does not set the difficulty' do
        computer.set_difficulty('Extreme')
        expect(computer.difficulty).to be(nil)
      end
    end

    context "when sending 'Easy' as parameter" do
      it "sets the difficulty to 'Easy'" do
        computer.set_difficulty('Easy')
        expect(computer.difficulty).to eq('Easy')
      end
    end

    context "when sending 'Medium' as parameter" do
      it "sets the difficulty to 'Medium'" do
        computer.set_difficulty('Medium')
        expect(computer.difficulty).to eq('Medium')
      end
    end

    context "when sending 'Hard' as parameter" do
      it "sets the difficulty to 'Hard'" do
        computer.set_difficulty('Hard')
        expect(computer.difficulty).to eq('Hard')
      end
    end
  end
end
