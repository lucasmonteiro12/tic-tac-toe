require_relative '../human'

describe Human do
  it { expect(described_class.superclass).to be Player }

  describe 'initialize' do
    it "sets @icon to the given parameter" do
      human = Human.new('X')
      expect(human.icon).to eq('X')
    end
  end
end
