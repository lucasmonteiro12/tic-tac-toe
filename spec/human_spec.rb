require_relative '../human'

describe Human do
  describe 'initialize' do
    it "sets @icon to the given parameter" do
      human = Human.new('X')
      expect(human.icon).to eq('X')
    end
  end
end
