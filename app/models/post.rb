class Post < ActiveRecord::Base
  belongs_to :user
  has_many :comments
  has_many :post_categories
  has_many :categories, through: :post_categories
  has_many :votes, as: :voteable

  validates :title, presence: true, length: {minimum: 5}
  validates :description, presence: true
  validates :url, presence: true, uniqueness: true

	# the model is where we put business logic and data level concerns

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