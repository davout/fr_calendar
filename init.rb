# FormBuilder date_select overrides 
require File.dirname(__FILE__) + '/lib/action_view'
require File.dirname(__FILE__) + '/lib/helpers/view'

def copy_files(source_path, destination_path, directory)
  source, destination = File.join(directory, source_path), File.join(RAILS_ROOT, destination_path)
  FileUtils.mkdir(destination) unless File.exist?(destination)
  FileUtils.cp_r(Dir.glob(source+'/*.*'), destination)
end

directory = File.dirname(__FILE__)

copy_files("/public", "/public", directory)

available_frontends = Dir[File.join(directory, 'frontends', '*')].collect { |d| File.basename d }
[ :javascripts, :images ].each do |asset_type|
  path = "/public/#{asset_type}/fr_calendar"
  
  FileUtils.rm_rf(File.join(RAILS_ROOT, path))
  
  copy_files(path, path, directory)
  
  File.open(File.join(RAILS_ROOT, path, 'DO_NOT_EDIT'), 'w') do |f|
    f.puts "Any changes made to files in sub-folders will be lost."
  end

  available_frontends.each do |frontend|
    source = "/frontends/#{frontend}/#{asset_type}/"
    destination = "/public/#{asset_type}/fr_calendar/#{frontend}"
    copy_files(source, destination, directory)
  end
end

ActionView::Base.send(:include, FrCalendar::Helpers::View)