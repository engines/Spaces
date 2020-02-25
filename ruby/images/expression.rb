require_relative '../spaces/model'
require_relative '../domains/bucket'
require_relative '../environments/bucket'

module Images
  class Expression < ::Spaces::Model
    include Domains::Bucket
    include Environments::Bucket

    relation_accessor :context
    attr_accessor :value

    def resolved
      begin
        vs = value.split('.').last(2)
        collaborate_with(vs.first).send(vs.last)
      rescue NoMethodError
        "--->#{value}<---"
      end
    end

    def collaborate_with(name)
      tensor.dependencies.named(name) ||
      tensor.domain ||
      (raise NoMethodError)
    end

    def initialize(value:, context:)
      self.value = value
      self.context = context
    end

    def tensor
      context.tensor
    end

    def to_s
      resolved
    end

  end
end


# A LIST OF EXPRESSION PARAMETERS HARVESTED FROM VERSION 1 SYSTEM
#
# _Engines_Builder
# http_protocol
# fqdn
# engine_name
# data_uid
# data_gid
# domain_name
# cont_user_id
# action_val(export_pkcs12,common_name))
# service_password(8)
#
# _Engines_Field
# cn
#
# _Engines_Environment
# dbhost
# dbname
# dbuser
# dbpasswd
# admin_email
# VOLDIR
# volume_name
# service_account()
# ldap_password
# elasticsearch_uri
# Admin_Password
# admin_password
# admin_pager_email
