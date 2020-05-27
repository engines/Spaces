require_relative '../spaces/model'
require_relative 'subject'

module Images
  class Image < ::Spaces::Model

    relation_accessor :subject
    def step_precedence
       {             
         early: [:inject, :install],
         late: [:source_persistence, :finish]
       }
    delegate(docker_file: :subject)

    def initialize(subject)
      self.subject = subject
    end

    def build
      Docker::Image.build_from_dir(path_for(subject), { 'dockerfile' =>  docker_file.path })
    end

  end
end
