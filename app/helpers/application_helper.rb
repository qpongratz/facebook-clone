module ApplicationHelper
  include Pagy::Frontend

  def nested_dom_id(*args)
    args.reject(&:nil?).map { |arg| arg.respond_to?(:to_key) ? dom_id(arg) : arg }.join('_')
  end

  def nested_li(objects, &block)
    objects = objects.order(:lft) if objects.is_a? Class

    return '' if objects.empty?

    output = ''
    path = [nil]

    objects.each do |o|
      if o.parent_id != path.last
        # We are on a new level, did we descend or ascend?
        if path.include?(o.parent_id)
          # Remove the wrong trailing path elements
          while path.last != o.parent_id
            path.pop
            output << '</ul>'
            # output << turbo_wrapper_end
          end
        else
          path << o.parent_id
          # output << turbo_wrapper_start(o)
          output << '<ul>'
        end
      end
      output << capture(o, path.size - 1, &block)
    end

    output.html_safe
  end

  def sorted_nested_li(objects, order, &block)
    nested_li sort_list(objects, order), &block
  end

  private

  def turbo_wrapper_end
    '</turbo-frame>'
  end

  def turbo_wrapper_start(object)
    "<turbo-frame id='#{object.commentable_type}_#{object.commentable_id}_#{object.parent_id}_comments'>"
  end

  def sort_list(objects, order)
    objects = objects.order(:lft) if objects.is_a? Class

    # Partition the results
    children_of = {}
    objects.each do |o|
      children_of[o.parent_id] ||= []
      children_of[o.parent_id] << o
    end

    # Sort each sub-list individually
    children_of.each_value do |children|
      children.sort_by!(&order)
    end

    # Re-join them into a single list
    results = []
    recombine_lists(results, children_of, nil)

    results
  end

  def recombine_lists(results, children_of, parent_id)
    if children_of[parent_id]
      children_of[parent_id].each do |o|
        results << o
        recombine_lists(results, children_of, o.id)
      end
    end
  end
end
