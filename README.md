# oo-membership-knife

Simple Openshift Origin broker utility for inserting memberships to
places where they don't belong to. Intended use case is allowing backups
with `rhc snapshot` utility by injecting a backup user with view
privileges.

## Usage

The utility allows add and remove operations that operate either on a
single domain or all domains. Added or removed member can be an user or
a team.

```
oo-membership-knife -c add -l <user login> -d <domain namespace>
```

## Testing

A set of tests that depends heavily on `rhc` is included. The tests are
run against the latest Openshift Origin v4 from
https://install.openshift.com/. To run the tests replace the Vagrant box
in the Vagrantfile with a CentOS 6 box from Atlas and prepare for the 2h
runtime.
