class Comment < ApplicationRecord

  belongs_to :commentable, polymorphic: true
  belongs_to :user

  acts_as_nested_set

  def self.preload_tree(actual_depth = nil)
    # get max_depth
    max_depth = Category.unscoped.maximum(:depth)
    actual_depth ||= minimum(:depth)

    return all if max_depth.nil? || actual_depth.nil?

    preloading = :children

    (max_depth - actual_depth).times do
      preloading = { children: [preloading, :user] } # you can include some other preloads here, if you want, like this: [preloading, :articles]
    end

    includes(preloading) # or preload, just a matter of taste here
  end
end
