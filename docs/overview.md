# Empty CloudFormation Stacks using WaitConditionHandle

Use the provided AWS CloudFormation templates to learn how to generate unique (or pseudo-unique) resouce names within AWS CloudFormation. It is recommended to invoke the CloudFormation templates using the `Makefile` task runner at the root of the repository, but it is possible to deploy these CloudFormation Stacks through the user interface.

These are sample templates, and not intended for launching production-level environments. Before launching a template, always review the resources that it will create and the permissions it requires.

## Getting Started

For working with the repository, you will need an [Amazon Web Services (AWS)](https://aws.amazon.com/) account, for which the permissions are sufficient to provision and destroy CloudFormation Stacks. For simplicity, a [gitpod](./.gitpod) environment is included with the repository, should you be familiar with Cloud Development Environments (CDEs).

If you are working locally, you will need to ensure that the following tools are installed:

- [make](https://www.gnu.org/software/make/)
- [awscli](https://aws.amazon.com/cli/)

This repository uses `make` as a task runner & interface for the CloudFormation commands. It is recommended when entering the repository within the Development Environment to run `make help` to see a list of available commands, and the related documentation.

> `make help` is only accessible from within the [development environment](./.gitpod), as it is imported from the `GLOBAL_MAKEFILE_LIBRARY`.

## Deploying into CloudFormation

> Before starting you should make sure you have authenticated to AWS with the [awscli](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-configure.html)

To initialize an empty CloudFormation Stack that creates no resources, you can run the make command `cfn-init`. This will deploy into CloudFormation a stack that uses a `WaitConditionHandle` as the sole resource. You can run this as follows:

```bash
make cfn-init
```

This will construct a stack with the name `aws-cfn-empty-template-stacks`, as seen in the command logs:

```text

Waiting for changeset to be created..
Waiting for stack create/update to complete
Successfully created/updated stack - aws-cfn-empty-template-stacks
```

> You can modify the CloudFormation stack name using the `STACK_NAME` variable

The CloudFormation template that has been deployed is located at [cloudformation/empty/stack.template.yaml](cloudformation/empty/stack.template.yaml), which contains just metadata and the `WaitConditionHandle`. The [WaitConditionHandle](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-waitconditionhandle.html) resource is necessary as a CloudFormation stack cannot be created without resources, and a `WaitConditionHandle` is an internal stack resource that doesn't require us to provision anything within AWS. Provisioning this allows us to get a working CloudFormation Stack without needing to worry about troubleshooting a failed stack create.
