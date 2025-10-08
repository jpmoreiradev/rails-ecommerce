module ApplicationHelper
  def primary_button(text, path)
    link_to text, path, class: "bg-blue-500 text-white py-2 px-4 rounded hover:bg-blue-600"
  end
end
