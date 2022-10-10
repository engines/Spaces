# load the code!
# require './x/common/controllers'

# ------------------------------------------------------------------------------

# save the provider role classifiers
controllers.classifying.create(
  model: {
    identifier: 'provider_role',
    sub_classifiers: [
      {
        identifier: :runtime
      },
      {
        identifier: :packing
      },
      {
        identifier: :orchestration
      }
    ]
  }
)

# save the provider classifier
controllers.classifying.create(
  model: {
    identifier: 'provider',
    sub_classifiers: [
      {
        identifier: :docker,
        roles: [
          :runtime,
          :packing
        ]
      },
      {
        identifier: :docker_compose,
        roles: [
          :orchestration
        ]
      },
      {
        identifier: :terraform,
        roles: [
          :orchestration
        ],
        attributes: [
          :compute_identifier
        ]
      },
      {
        identifier: :aws,
        attributes: [
          :account_identifier,
          :region
        ]
      }
    ]
  }
)
