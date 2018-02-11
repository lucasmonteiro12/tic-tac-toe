require_relative '../computer'
require_relative '../player'

describe Computer do
  it { expect(described_class.superclass).to be Player }

  describe 'initialize' do
    it "sets @icon to the given parameter" do
      computer = Computer.new('X')
      expect(computer.icon).to eq('X')
    end
  end
end
