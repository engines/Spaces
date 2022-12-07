module Artifacts
  module Terraform
    class Artifact < ::Artifacts::Artifact

      def filename =
        "#{emission.application_identifier}.#{qualifier}.#{extension}"

      def extension = :tf

      def dns_address =
        "#{container_type}.#{resource_identifier}.ipv4_address"

      def container_type =
        [runtime_qualifier, 'container'].compact.join('_')

      def content = super.as_prettier_hcl

    end
  end
end


class String

  def as_prettier_hcl
    opener = /[({\[]/
    closer = /[)}\]]/
    indent_level = 0

    split("\n").map(&:strip).reject(&:empty?).join("\n").gsub('resource ', "\nresource ").chars.map do |c|
      case c
      when opener
        indent_level += 1
      when closer
        indent_level -= 1
      when "\n"
        c = "#{c}#{' ' * (indent_level * 2)}"
      end
      c
    end.join
  end

end
