class StoriesController < InheritedResources::Base
  before_filter :authenticate_user!, only: [:new, :create, :destroy]

	def new
		if params[:parent_id].nil?
			@story = current_user.stories.new(
				keyword: Story.generated_keyword,
				children_keyword: Story.generated_keyword
			)
		else
			parent_id = params[:parent_id]
			parent_story = Story.find(parent_id)
			if parent_story.depth < parent_story.deep
				@story = current_user.stories.new(
					deep: parent_story.deep,
					parent: parent_story,
					keyword: parent_story.children_keyword,
					children_keyword: Story.generated_keyword
				)
			else
				@story = nil
				@error_message = "finished"
			end
		end
	end

	def destroy
		
	end

  private

  def story_params
    params.require(:story).permit(:deep, :body, :user_id, :keyword, :children_keyword, :parent_id)
  end
end

