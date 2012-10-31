class Expense < ActiveRecord::Base
  attr_accessible :amount, :description, :title

  has_many :transactions
  has_many :users, :through => :transactions

  belongs_to :payer, :class_name => 'User'
end