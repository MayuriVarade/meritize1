module ApplicationHelper

    def title
     base_title = "Ruby on Rails Tutorial Sample App"
       if @title.nil?
        base_title
       else
        "#{base_title} | #{@title}"
       end
     end
     def format_boolean(status)
        if status
          icon_tick
        else
          icon_cross
        end
      end
      
      def icon_tick(alt_text='Tick')
     build_image_tag("/assets/deactivate.png", alt_text)
      end

      def icon_cross(alt_text='Cross')
        build_image_tag("/assets/activate.png", alt_text)

      end
      
      def build_image_tag(image_file, alt_text)
        image_tag(image_file, :alt => alt_text)
      end
      def avatar_url(user)
        gravatar_id = Digest::MD5::hexdigest(user.email).downcase
        "http://gravatar.com/avatar/#{gravatar_id}.png"
      end
      def link_to_remove_fields(name, f)

         f.hidden_field(:_destroy) + link_to_function(name, "remove_fields(this)")
      end

      def link_to_add_fields(name, f, association)
          new_object = f.object.class.reflect_on_association(association).klass.new
          fields = f.fields_for(association, new_object, :child_index => "new_#{association}") do |builder|
            render(association.to_s.singularize + "_fields", :f => builder)
          end
           link_to_function(name, ("add_fields(this, '#{association}', '#{escape_javascript(fields)}')"))

      end
      
      
      def plan_expiry
      @trial_days = TrialDay.first
      @plan_expiry = (current_user.created_at + @trial_days.days.days)
      @current_date = (Time.zone.now)
      @remaining_days = (@plan_expiry - @current_date).to_i / 1.day
      end
end
