require_relative 'hash'

module Artifacts
  module CloudFormation
    module Aws
      module Formats
        class ContainerRegistry < Hash

          def content = [super, policy_snippet, push_images_snippet]

          def policy_snippet =
            {
              "#{resource_identifier}RepositoryPolicy": {
                type: 'AWS::ECR::RepositoryPolicy',
                properties: {
                  repository_name: "!Ref #{resource_identifier}",
                  policy_text: {
                    version: "2008-10-17",
                    statement: [
                      {
                        sid: "adds full ecr access to the demo repository",
                        effect: "Allow",
                        principal: "*",
                        action: [
                          'ecr:BatchCheckLayerAvailability',
                          'ecr:BatchGetImage',
                          'ecr:CompleteLayerUpload',
                          'ecr:GetDownloadUrlForLayer',
                          'ecr:GetLifecyclePolicy',
                          'ecr:InitiateLayerUpload',
                          'ecr:PutImage',
                          'ecr:UploadLayerPart'
                        ]
                      }
                    ]
                  }
                }
              }
            }.deep(:camelize, of: :keys)

          def push_images_snippet =
            [
              "#{resource_identifier}CustomResource": {
                type: 'Custom::CustomResource',
                properties: {
                  ServiceToken: %(!GetAtt ["#{resource_identifier}Function", "Arn"]),
                  ECRRepository: %(!Ref #{resource_identifier})
                }
              },
              "#{resource_identifier}Function": {
                type: 'AWS::Lambda::Function',
                properties: {
                  Description: 'Custom resource to execute Docker push commands to the ECR repository',
                  FunctionName: "#{resource_identifier}Function",
                  MemorySize: 128,
                  Role: '!GetAtt [CustomResourceFunctionRole, Arn]',
                  Runtime: 'nodejs12.x',
                  Timeout: 300,
                  Code: {
                    ZipFile:
                      %(
                        const AWS = require("aws-sdk");
                        const ecr = new AWS.ECR();
                        const exec = require("await-exec");

                        exports.handler = async (event) => {
                          try {
                            console.log("Event:", JSON.stringify(event));
                            const login = await ecr.getAuthorizationToken().promise();
                            const authorizationToken = login.authorizationData[0].authorizationToken;
                            const registryId = login.authorizationData[0].registryId;
                            const proxyEndpoint = login.authorizationData[0].proxyEndpoint;

                            const command = `#{login_command}` &&
                            #{image_push_commands}; echo 0
                          }
                        }
                      )
                  }
                }
              }
            ].deep(:camelize, of: :keys)

        end
      end
    end
  end
end
