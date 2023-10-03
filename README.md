# Swift Rust Xcode Template

[![Build Status](https://github.com/n8henrie/swift-rust-xcode-template/workflows/Template/badge.svg)](https://github.com/n8henrie/swift-rust-xcode-template/actions)

This is a template for quickly building an iOS app in rust and swift. It uses
`cbindgen` to build `bindings.h` for convenient rust-swift interop.

To use this with [cargo-generate](https://github.com/cargo-generate/cargo-generate) do:

```console
$ cargo generate --git https://github.com/n8henrie/swift-rust-xcode-template.git --name myproject
$ cd myproject
```

To build the rest of the app/project you'll need to add the appropriate
targets:

```console
$ rustup target add aarch64-apple-ios aarch64-apple-ios-sim`
```

You may also need to add `x86_64-apple-ios`; for running in the simulator on my
M1 Mac and my iPhone 13, the above targets seem to be sufficient. Please open
an issue if adding `x86_64` would be helpful for you!

Building from within XCode should work; it calls `./xcode-build-script.sh`,
which runs the `cargo build` steps.

Currently, there's some very rudimentary swift code that calls the rust with a
closure passed in. You can see that code
[here](https://github.com/n8henrie/swift-rust-xcode-template/blob/74e90a61aa63dc7d2fac37b3a4f7cec17fd81171/swift-rust-xcode-template/AppDelegate.swift#L18-L29).

## Template Maintenance

In my experience, XCode doesn't play very well with templating tools like
`cookiecutter` or `cargo generate`. @simlay was using `./rename.sh`, which I
have updated a bit, but hopefully should no longer be necessary as I've
included the `cargo-generate` templates into the XCode project structure
itself, which seems to work.

I'm leaving `rename.sh` around, however, since it provides a handy template for
batch renaming in the project, and I'm sure there are still a few bugs and edge
cases in which a `project-name` that's suitable for Rust doesn't work well in
XCode, and vice-versa.
