module ActionView
  module Helpers
    class FormBuilder      
      def date_select(method, options = {}, html_options = {})
        field_id = "date_select_" + @object.class.to_s.underscore + "_" + @object.id.to_s + "_" + method.to_s + "_" + (rand*10**6).floor.to_s
        
        date_string = ""
        date_string = @object.send(method).strftime("%d/%m/%Y") unless @object.send(method).nil?

        db_date_string = ""
        db_date_string = @object.send(method).strftime("%Y-%m-%d") unless @object.send(method).nil?

        html = @template.hidden_field_tag("#{@object.class.to_s.underscore}[#{method}]", db_date_string, :class => "date-selector-hidden", :id => "#{field_id}_hidden")
        html += @template.text_field_tag(field_id , date_string, :onchange => "updateHiddenDate(this);", :onblur => "onDateFieldBlur(this);", :class => "fr-calendar-date-input input_mask mask_date_fr")
        html += calendar_button_for_date(@object, method, field_id)
        @template.content_tag 'span', html
      end

      def datetime_select(method, options = {}, html_options = {})
        field_id = "datetime_select_" + @object.class.to_s.underscore + "_" + @object.id.to_s + "_" + method.to_s + "_" + (rand*10**6).floor.to_s

        datetime_string = ""
        datetime_string = @object.send(method).strftime("%d/%m/%Y %H:%M") unless @object.send(method).nil?

        db_datetime_string = ""
        db_datetime_string = @object.send(method).strftime("%Y-%m-%d %H:%M") unless @object.send(method).nil?

        html = @template.hidden_field_tag("#{@object_name}[#{method}]", db_datetime_string, :class => "datetime-selector-hidden", :id => "#{field_id}_hidden")
        html += @template.text_field_tag(field_id , datetime_string, :onchange => "updateHiddenDateTime(this);", :onblur => "onDateTimeFieldBlur(this);", :class => "fr-calendar-datetime-input input_mask mask_datetime_fr")
        html += calendar_button_for_datetime(@object, method, field_id)
        @template.content_tag 'span', html
      end

      private
      def calendar_button_for_date(object, method, field_id)
        str = @template.image_tag("fr_calendar/default/calendar.png", :alt => "Sélecteur de date", :title => "Sélecteur de date", :id => field_id + "_img", :class => "fr-calendar-button")
        str += "<script language=\"JavaScript\">setupCalendarFor('" + field_id + "_hidden', '" + field_id + "', false);</script>"
      end

      def calendar_button_for_datetime(object, method, field_id)
        str = @template.image_tag("fr_calendar/default/calendar.png", :alt => "Sélecteur de date", :title => "Sélecteur de date", :id => field_id + "_img", :class => "fr-calendar-button")
        str += "<script language=\"JavaScript\">setupCalendarFor('" + field_id + "_hidden', '" + field_id + "', true);</script>"
      end
    end
    module DateHelper
      def datetime_select_tag(name, value=nil, options={})
        field_id = "datetime_select_" + (rand*10**6).floor.to_s

        datetime_string = value.blank? ? nil : value.strftime("%d/%m/%Y %H:%M")
        db_datetime_string = value.blank? ? nil : value.strftime("%Y-%m-%d %H:%M") 

        html = @template.hidden_field_tag(name, db_datetime_string, :class => "datetime-selector-hidden", :id => "#{field_id}_hidden")
        html += @template.text_field_tag(field_id , datetime_string, :onchange => 'updateHiddenDateTime(this)', :onblur => 'onDateTimeFieldBlur(this)', :class => 'fr-calendar-datetime-input input_mask mask_datetime_fr')
        html += @template.image_tag("fr_calendar/default/calendar.png", :alt => "Sélecteur de date", :title => "Sélecteur de date", :id => field_id + "_img", :class => "fr-calendar-button")
        html += "<script language='JavaScript'>setupCalendarFor('#{field_id}_hidden','#{field_id}', true)</script>"

        @template.content_tag 'span', html
      end
    end
#    def date_select(name, id, date = DateTime.now, options = {}, html_options = {})
#      field_id = id.to_s
#      date_string = date.strftime("%d/%m/%Y")
#
#      html = hidden_field(name.to_s, :class => "date-selector-hidden", :id => field_id + "_hidden")
#      html += @template.text_field_tag(field_id , date_string, :onchange => "updateHiddenDate(this);", :onblur => "onDateFieldBlur(this);", :class => "fr-calendar-date-input  input_mask mask_date_fr")
#      html += calendar_button_for_date(name, field_id)
#      @template.content_tag 'span', html
#    end

#    def datetime_select(name, id, date = DateTime.now, options = {}, html_options = {})
#      field_id = id.to_s
#      date_string = date.strftime("%d/%m/%Y %H:%M")
#
#      html = hidden_field(name.to_s, :class => "datetime-selector-hidden", :id => field_id + "_hidden")
#      html += @template.text_field_tag(field_id , date_string, :onchange => "updateHiddenDate(this);", :onblur => "onDateFieldBlur(this);", :class => "fr-calendar-datetime-input  input_mask mask_datetime_fr")
#      html += calendar_button_for(name, field_id)
#      @template.content_tag 'span', html
#    end
#
#    def calendar_button_for_date(object, field_id)
#      str = @template.image_tag("fr_calendar/default/calendar.png", :alt => "Sélecteur de date", :title => "Sélecteur de date", :id => field_id + "_img", :class => "fr-calendar-button")
#      str += "<script language=\"JavaScript\">setupCalendarFor('" + field_id + "_hidden', '" + field_id + "');</script>"
#      str
#    end
  end
end