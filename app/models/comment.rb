class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :post
  has_many :votes, as: :voteable

  validates :body, presence: true

	def up_vote
		self.votes.where(vote: true).size
	end

	def down_vote
		self.votes.where(vote: false).size
	end

	def total_votes
		up_vote - down_vote				
	end
end
