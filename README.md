# wayland

Work-in-progress Nim bindings for libwayland.

This aims to wrap and provide idiomatic bindings for the Wayland protocol. It currently binds the entirety of Wayland 1.21.0, but should not be considered feature-complete or stable until tests have been written and a release has been made.

These differ from [yglukhov's bindings](https://github.com/yglukhov/wayland) by being more comprehensive, but a work in progress (untested and not particularly idiomatic, yet).

## Todo

- [ ] Write some tests
- [ ] Replace various `ptr T` parameters with ptr types
- [ ] Decide on a prefix convention for types
  - Background: wayland and wlroots have identically-named types, so just removing the `Wl` and `Wlr` prefixes will cause conflicts
  - Currently the `Wl` prefix here is kept while the `Wlr` prefix in `nim-wlroots` is removed
  - Is this the best way forward? Probably not
