module NavigationHelpers
  include Bootsy::Engine.routes.url_helpers
  def path_to(page_name)
    case page_name
 
    when /the home\s?page/
      '/'
    when 'its edit page'
      edit_post_path(Post.last)
    else
      begin
        page_name =~ /the (.*) page/
        path_components = $1.split(/\s+/)
        self.send(path_components.push('path').join('_').to_sym)
      rescue Object => e
        raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
          "Now, go and add a mapping in #{__FILE__}"
      end
    end
  end

  def path_to_file filename
    Rails.root.to_s + "/public/" + filename
  end
end

World(NavigationHelpers)