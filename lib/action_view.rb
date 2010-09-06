module ActionView
  module Helpers
    class FormBuilder      
      def date_select(method, options = {}, html_options = {})
        field_id = "date_select_" + @object.class.to_s.underscore + "_" + @object.id.to_s + "_" + method.to_s + "_" + (rand*10**6).floor.to_s
        
        date_string = ""
        date_string = @object.send(method).strftime("%d/%m/%Y") unless @object.send(method).nil?

        db_date_string = ""
        db_date_string = @object.send(method).strftime("%Y-%m-%d") unless @object.send(method).nil?

        html = @template.hidden_field(method, :class => "date-selector-hidden", :id => "#{field_id}_hidden")
        html = "#{html}#{@template.text_field(method, :onchange => "updateHiddenDate(this);", :onblur => "onDateFieldBlur(this);", :onclick => "selectTextIn(this);", :class => "fr-calendar-date-input")}"
        html = "#{html}#{calendar_button_for_date(@object, method, field_id)}"
        @template.content_tag 'span', html
      end

      def datetime_select(method, options = {}, html_options = {})
        field_id = "datetime_select_" + @object.class.to_s.underscore + "_" + @object.id.to_s + "_" + method.to_s + "_" + (rand*10**6).floor.to_s

        datetime_string = ""
        datetime_string = @object.send(method).strftime("%d/%m/%Y %H:%M") unless @object.send(method).nil?

        db_datetime_string = ""
        db_datetime_string = @object.send(method).strftime("%Y-%m-%d %H:%M") unless @object.send(method).nil?

        html = @template.hidden_field_tag("#{@object_name}[#{method}]", db_datetime_string, :class => "datetime-selector-hidden", :id => "#{field_id}_hidden")
        html = "#{html}#{@template.text_field_tag(field_id , datetime_string, :onchange => "updateHiddenDateTime(this);", :onblur => "onDateTimeFieldBlur(this);", :onclick => "selectTextIn(this);", :class => "fr-calendar-datetime-input")}"
        html = "#{html}#{calendar_button_for_datetime(@object, method, field_id)}"
        @template.content_tag 'span', html
      end

      private
      def calendar_button_for_date(object, method, field_id)
        str = @template.image_tag("fr_calendar/default/calendar.png", :alt => "Sélecteur de date", :title => "Sélecteur de date", :id => field_id + "_img", :class => "fr-calendar-button")
        str = "#{str}<script type=\"text/javascript\" language=\"JavaScript\">setupCalendarFor('" + field_id + "_hidden', '" + field_id + "', false);</script>"
      end

      def calendar_button_for_datetime(object, method, field_id)
        str = @template.image_tag("fr_calendar/default/calendar.png", :alt => "Sélecteur de date", :title => "Sélecteur de date", :id => field_id + "_img", :class => "fr-calendar-button")
        str = "#{str}<script type=\"text/javascript\" language=\"JavaScript\">setupCalendarFor('" + field_id + "_hidden', '" + field_id + "', true);</script>"
      end
    end
    
    module DateHelper
      def datetime_select_tag(name, value=nil, options={})
        field_id = "datetime_select_" + (rand*10**6).floor.to_s

        datetime_string = value.blank? ? nil : value.strftime("%d/%m/%Y %H:%M")
        db_datetime_string = value.blank? ? nil : value.strftime("%Y-%m-%d %H:%M") 

        html = @template.hidden_field_tag(name, db_datetime_string, :class => "datetime-selector-hidden", :id => "#{field_id}_hidden")
        html = "#{html}#{@template.text_field_tag(field_id , datetime_string, :onchange => 'updateHiddenDateTime(this)', :onblur => 'onDateTimeFieldBlur(this)', :onclick => "selectTextIn(this);", :class => 'fr-calendar-datetime-input')}"
        html = "#{html}#{@template.image_tag("fr_calendar/default/calendar.png", :alt => "Sélecteur de date", :title => "Sélecteur de date", :id => field_id + "_img", :class => "fr-calendar-button")}"
        html = "#{html}<script type=\"text/javascript\" language='JavaScript'>setupCalendarFor('#{field_id}_hidden','#{field_id}', true)</script>"

        @template.content_tag 'span', html
      end

      def date_select_tag(name, value=nil, options={})
        field_id = "date_select_" + (rand*10**6).floor.to_s

        date_string = value.blank? ? nil : value.strftime("%d/%m/%Y")
        db_date_string = value.blank? ? nil : value.strftime("%Y-%m-%d")

        html = @template.hidden_field_tag(name, db_date_string, :class => "date-selector-hidden", :id => "#{field_id}_hidden")
        html = "#{html}#{@template.text_field_tag(field_id , date_string, :onchange => 'updateHiddenDate(this)', :onblur => 'onDateFieldBlur(this)', :onclick => "selectTextIn(this);", :class => 'fr-calendar-date-input')}"
        html = "#{html}#{@template.image_tag("fr_calendar/default/calendar.png", :alt => "Sélecteur de date", :title => "Sélecteur de date", :id => field_id + "_img", :class => "fr-calendar-button")}"
        html = "#{html}<script type=\"text/javascript\" language='JavaScript'>setupCalendarFor('#{field_id}_hidden','#{field_id}', false)</script>"

        @template.content_tag 'span', html
      end
    end
  end
end