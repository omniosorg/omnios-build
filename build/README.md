
The following packages are currently stuck:

- pycurl
  stuck on 7.44.1 - https://github.com/pycurl/pycurl/issues/748

- jsonschema
  stuck on 4.17.3.
  4.18.0 brings in a new dependency on "referencing" which itself has a
  dependency on "rpds-py", which is in rust and depends on a crate called
  "maturin", which has a dependency on "platform-info", which does not have
  illumos support in the latest released version.

  illumos support is in the master branch of "platform-info", so we could
  update once a new version is released if we were content to add the extra
  dependencies, or move jsonschema to bundled with pkg5, but we also need to
  come up with a strategy for aarch64 since that does not yet have rust.

