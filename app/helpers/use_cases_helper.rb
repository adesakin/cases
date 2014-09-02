module UseCasesHelper
  def section_header(name, option=nil)
    content_tag :table, class: "large-12 medium-12 columns flows" do
      content_tag :thead do
        content_tag :tr do
          content_tag :th do
            content_tag :h5, "#{name.titleize} #{option.nil? ? "" : "_" + option}"
          end
        end
      end
    end


#    <table id="#{name.downcase}#{option.nil? ? "" : "_" + option}" class="large-12 medium-12 columns #{option.nil? ? "" : "_" + option}">
 #     <thead>
 #       <tr>
 #         <th>"#{name} #{option.nil? ? "" : "_" + option}"</th>
 #       </tr>
 #     </thead>
 #   </table>
  end
end
