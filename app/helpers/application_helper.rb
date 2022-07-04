module ApplicationHelper
  include Pagy::Frontend

  def nested_dom_id(*args)
    args.reject(&:nil?).map { |arg| arg.respond_to?(:to_key) ? dom_id(arg) : arg }.join('_')
  end

  def render_turbo_stream_flash_messages
    turbo_stream.prepend 'flash', partial: 'layouts/flash'
  end

end
