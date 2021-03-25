# def packing_commit_for(pack_identifier)
#   build = YAML.load_file(universe.workspace.join("Universe", "PackingSpace", pack_identifier, "commit", "output.yaml"))
#   {
#     built: true,
#     messages: build.ui_messages.map do |ui_message|
#       {
#         type: ui_message.ui_message_type,
#         output: ui_message.output,
#       }
#     end
#   }
# rescue Errno::ENOENT
#   nil.to_json
# end
