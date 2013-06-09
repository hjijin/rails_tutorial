module MicropostsHelper
  # 定义 wrap 帮助方法防止特别长的单词会撑破布局。
  # 注意，其中用到的 raw 方法是为了避免 Rails 转义 HTML 代码，sanitize 方法是为了防止跨站脚本攻击。
  def wrap(content)
    sanitize(raw(content.split.map{ |s| wrap_long_string(s) }.join(' ')))
  end

  private

    def wrap_long_string(text, max_width = 30)
      zero_width_space = "&#8203;"
      regex = /.{1,#{max_width}}/
      (text.length < max_width) ? text : text.scan(regex).join(zero_width_space)
    end
end