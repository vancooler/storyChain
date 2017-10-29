class Story < ActiveRecord::Base
	belongs_to :user

	has_ancestry

	validates_length_of :body, minimum: 1, maximum: 50
	validates_presence_of :body, :deep, :user, :keyword, :children_keyword

	validate :keyword_used

	def self.generated_keyword
		LiterateRandomizer.word
	end

	private

	def keyword_used
		# binding.pry
    unless body.include? keyword
      errors.add(:body, "Keyword must be used in this chapter")
    end
  end
end
