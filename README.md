# Swift Rust Xcode Template

[![Build Status](https://github.com/simlay/{{crate_name}}/workflows/Template/badge.svg)](https://github.com/simlay/{{crate_name}}/actions)

This is a template for quickly building an iOS app in rust and swift. It uses
`cbindgen` to build `bindings.h` for convenient rust-swift interop.

To use this with [cargo-generate](https://github.com/ashleygwilliams/cargo-generate) do:
```
cargo generate --git https://github.com/simlay/{{crate_name}}.git --name myproject
cd myproject
./rename.sh
```

The `./rename.sh` step renames the xcode stuff to match your project name.

To build the rest of the app/project you'll need to run:
* `cargo install cargo-lipo`
* `rustup target add aarch64-apple-ios x86_64-apple-ios`

After that you can build the app via the Xcode zoom-zoom-play button or run:
`xcodebuild -target myproject -configuration Debug -scheme my-test-app -sdk iphonesimulator13.2`

Currently, there's some very rudimentary swift code that calls the rust with a
closure passed in. You can see that code
[here](https://github.com/simlay/{{crate_name}}/blob/74e90a61aa63dc7d2fac37b3a4f7cec17fd81171/{{crate_name}}/AppDelegate.swift#L18-L29).


## Template Maintenance

Adding new things to this template is unfortunately annoying to add to or
maintain because of the template tags in
`{{crate_name}}.xcodeproj/project.pbxproj`, `rename.sh` and
`Cargo.toml`. This project is open to other work flows but here's what seems
like the least worst option:

```
git clone https://github.com/simlay/{{crate_name}}
cargo generate --git ./{{crate_name}} --name update-{{crate_name}}
cd update-{{crate_name}}
./rename.sh
```

modify your stuff and then `cp` the files back to the other directory.

I'f you're doing a lot of things you may want to symlink the `src/lib.rs`,
`{{crate_name}}/*.swift`, etc. to the {{crate_name}}
repo checkout.
