# System settings.
# TODO: Use real data!
def system_settings
  {
    label: {
      text: 'My server!',
      color: 'white',
      background_color: 'blue',
    }
  }
end

# Data needed for certain options on blueprint forms.
def blueprinting_settings
  {
    # build_scripts: Packing::Pack.script_file_names.map do |script|
    #   {script => Packing::Pack.script_choices_names(script)}
    # end.inject(:merge)
  }
end
