require 'spec_helper'

describe Group do
  it { should have_many(:users).through(:memberships) }
  it { should have_many(:expenses) }

  context "money" do
    before(:each) do
      @bob = User.create(:name => "bob", :email => "bob@bob.com", :password => "password")
      @alice = User.create(:name => "alice", :email => "alice@bob.com", :password => "password")
      @panda = User.create(:name => "panda", :email => "panda@bob.com", :password => "password")

      @group1 = Group.create(:name => "first", :currency_sign => "$")
      @group1.users << [@bob, @alice]

      @group2 = Group.create(:name => "second", :currency_sign => "$")
      @group2.users << [@panda, @alice]

      @breakfast = @group1.expenses.create(:amount => 6)
      @breakfast.payer = @bob
      @breakfast.users << [@bob, @alice, @panda]
      @breakfast.save

      @dinner = @group1.expenses.create(:amount => 10)
      @dinner.payer = @alice
      @dinner.users << [@bob, @alice]
      @dinner.save

      @tea = @group1.expenses.create(:amount => 8)
      @tea.payer = @alice
      @tea.users << [@bob, @panda]
      @tea.save

      @lunch = @group2.expenses.create(:amount => 20)
      @lunch.payer = @panda
      @lunch.users << [@panda, @alice]
      @lunch.save
    end

    it "should calculate amount owed by a given group member" do
      @group1.cumulative_amount_owed_by(@alice).should == 2
    end

    it "should calculate the amount owed by a given group member to another member" do
      @group1.rolled_up_amount_owed(:by => @alice, :to => @bob).should == -7
      @group1.rolled_up_amount_owed(:by => @bob, :to => @alice).should == 7
    end
    
    it "should calculate amount owed to a given group member" do
      @group1.cumulative_amount_owed_to(@alice).should == 13 #5 for dinner + 8 for tea
    end

    it "should calculate a rolled up dashboard amount for a group user" do
      @group1.rolled_up_cumulative_amount(@alice).should == 11
    end
  end
end
