module ApplicationHelper
    def popular_post
        Post.order("count DESC").limit(3)
    end
end
