require 'action_view/helpers/tag_helper'

module ActionView
  module Helpers
    class FormBuilder
      def date_selector(method, with_time, options ={}, html_options={})
        tags = []

        date_string, db_date_string = "", ""

        unless @object.send(method).nil?
          hours_minutes = with_time ? " %H:%M" : ""

          date_string = @object.send(method).strftime("%d/%m/%Y#{hours_minutes}")
          db_date_string = @object.send(method).strftime("%Y-%m-%d#{hours_minutes}")
        end

        random_id = (rand * 10 ** 9).floor.to_s

        time_string = with_time ? "time" : ""

        options.merge!(
          :value => db_date_string,
          :class => "date#{time_string}-selector-hidden",
          :id => "#{random_id}_hidden"
        )

        tags << InstanceTag.new(@object_name, method, self, options.delete(:object)).to_input_field_tag("hidden", options)

        options.merge!(
          :value => date_string,
          :class => "fr-calendar-date#{time_string}-input",
          :name => random_id,
          :id => random_id,
          :onchange => "updateHiddenDate#{time_string.capitalize}(this);",
          :onblur => "onDate#{time_string.capitalize}FieldBlur(this);",
          :onclick => "selectTextIn(this);"
        )

        tags << InstanceTag.new(@object_name, method, self, options.delete(:object)).to_input_field_tag("input", options)

        tags << calendar_button_for(random_id, with_time)

        @template.content_tag(:span, tags.to_s.html_safe)
      end

      def date_select(method, options={}, html_options={})
        date_selector(method, false, options, html_options)
      end

      def datetime_select(method, options={}, html_options={})
        date_selector(method, true, options, html_options)
      end

      private
      def calendar_button_for(random_id, with_time)
        tags = []

        tags << @template.image_tag("fr_calendar/default/calendar.png",
          :alt => "Sélecteur de date",
          :title => "Sélecteur de date",
          :id => "#{random_id}_img",
          :class => "fr-calendar-button"
        )

        js_options = {
          :type => "text/javascript",
          :language => "JavaScript"
        }
        
        tags << @template.content_tag(:script, js_options) do
          "setupCalendarFor('#{random_id}_hidden', '#{random_id}', #{with_time ? "true" : "false"});"
        end

        tags
      end
    end
    
    module DateHelper
      def datetime_select_tag(name, value=nil, options={})
        date_selector_tag(name, true, value, options)
      end

      def date_select_tag(name, value=nil, options={})
        date_selector_tag(name, false, value, options)
      end

      def date_selector_tag(name,  with_time, value=nil, options={})
        random_id = "date_select_" + (rand*10**6).floor.to_s

        date_string, db_date_string = "", ""

        if value
          hours_minutes = with_time ? " %H:%M" : ""

          date_string = value.strftime("%d/%m/%Y#{hours_minutes}")
          db_date_string = value.strftime("%Y-%m-%d#{hours_minutes}")
        end

        time_string = with_time ? "time" : ""

        options.merge!(
          :class => "date#{time_string}-selector-hidden",
          :id => "#{random_id}_hidden"
        )

        html = hidden_field_tag(name, db_date_string, options)

        options.merge!(
          :class => "fr-calendar-date#{time_string}-input",
          :name => random_id,
          :id => random_id,
          :onchange => "updateHiddenDate#{time_string.capitalize}(this);",
          :onblur => "onDate#{time_string.capitalize}FieldBlur(this);",
          :onclick => "selectTextIn(this);"
        )

        html << text_field_tag(random_id, date_string, options)
        
        html << image_tag("fr_calendar/default/calendar.png",
          :alt => "Sélecteur de date",
          :title => "Sélecteur de date",
          :id => random_id + "_img",
          :class => "fr-calendar-button"
        )

        js_options = {
          :type => "text/javascript",
          :language => "JavaScript"
        }
        
        html << content_tag(:script, js_options) do
          "setupCalendarFor('#{random_id}_hidden', '#{random_id}', #{with_time ? "true" : "false"});"
        end

        content_tag(:span, html.to_s.html_safe)
      end
    end
  end
end