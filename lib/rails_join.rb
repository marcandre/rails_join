require 'active_support/core_ext/string/output_safety'
require 'active_support/core_ext/module/aliasing.rb'

unless ["<br/>".html_safe, ">"].join("<") == "<br/>&lt;&gt;"
  class Array
    def join_with_safe_buffer_awareness(sep = $,)
      f = first
      if f.is_a?(ActiveSupport::SafeBuffer) && f.html_safe?
        map { |i| ERB::Util.html_escape(i) }.join_without_safe_buffer_awareness(ERB::Util.html_escape(sep)).html_safe
      else
        join_without_safe_buffer_awareness(sep)
      end
    end
    alias_method_chain :join, :safe_buffer_awareness
  end
end
