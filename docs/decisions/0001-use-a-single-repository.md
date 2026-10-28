# 0001: Use a single repository

## Status

Accepted.

## Context

Plasma Suite is a personal project comprising related iOS apps and self-hosted services. The apps will share client modules and may consume common data through services. Development is owned by one person, so independent team ownership and repository access boundaries are not needed.

## Decision

Keep the iOS apps, shared modules, backend services, deployment configuration, and project documentation in one repository.

This does not determine the build system, service boundaries, or deployment topology.

## Consequences

- Related client, service, and shared-module changes can be reviewed and committed together.
- Development conventions and tooling can be maintained in one place.
- Build and CI configuration must account for multiple components and avoid unnecessary work on unrelated changes.
- A single commit does not imply a simultaneous rollout; APIs must accommodate installed clients and services running different versions.
