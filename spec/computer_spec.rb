require_relative '../computer'

describe Computer do
  describe 'initialize' do
    it "sets @icon to the given parameter" do
      computer = Computer.new('X')
      expect(computer.icon).to eq('X')
    end
  end
end
