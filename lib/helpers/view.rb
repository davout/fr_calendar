module FrCalendar
  module Helpers
    module View
      def fr_calendar_includes
        js = %w{calendar calendar-setup lang/calendar-fr ../jscalendar-helpers}.inject("") { |m, i| m + javascript_include_tag("fr_calendar/default/jscalendar-1.0/#{i}") }
        css = stylesheet_link_tag "../javascripts/fr_calendar/default/jscalendar-1.0/skins/aqua/theme.css"         
        js + css
      end
    end
  end
end