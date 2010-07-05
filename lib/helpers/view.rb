module FrCalendar
  module Helpers
    module View
      def fr_calendar_includes
        js = javascript_include_tag("fr_calendar/default/jscalendar-1.0/calendar")
        js += javascript_include_tag("fr_calendar/default/jscalendar-1.0/calendar-setup")
        js += javascript_include_tag("fr_calendar/default/jscalendar-1.0/lang/calendar-fr")
        js += javascript_include_tag("fr_calendar/default/jscalendar-helpers")
        #js += javascript_include_tag("fr_calendar/default/input_mask")
        
        css = stylesheet_link_tag "../javascripts/fr_calendar/default/jscalendar-1.0/skins/aqua/theme.css" 
        
        js + css
      end
    end
  end
end