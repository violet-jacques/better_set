module BetterSet
  module Values
    RSpec.describe SetRelations do
      let(:dummy_class) { Class.new { include SetRelations } }
      subject { dummy_class.new }

      it { should be_a(SetRelations) }
      it { should be_an_instance_of(dummy_class) }
      it { should respond_to(:-) }
      it { should respond_to(:==) }
      it { should respond_to(:cartesian_product) }
      it { should respond_to(:difference) }
      it { should respond_to(:intersection) }
      it { should respond_to(:proper_subset?) }
      it { should respond_to(:proper_superset?) }
      it { should respond_to(:subset?) }
      it { should respond_to(:superset?) }
      it { should respond_to(:union) }
      it { should_not be_an_instance_of(Class) }
    end
  end
end
