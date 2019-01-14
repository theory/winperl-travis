Travis CI Windows + Strawberry Perl
===================================

[![Build Status](https://api.travis-ci.com/theory/winperl-travis.svg)](https://travis-ci.com/theory/winperl-travis)

A simple sample project for installing dependencies and running tests with
[Strawberry Perl] on the [Travis CI Windows Build Environment]. See the
[`.travis.yml`] file for the working code. The basic steps are:

*   Install Strawberry Perl
*   Add Strawberry Perl to the path
*   Install dependencies with [cpanminus]
*   Build and test your Perl project as usual

Stages
------

There are three basic approaches to testing  Perl project on Travis
Windows:

1.  Windows-Only default "Test" stage with version matrix
2.  Windows stage test with the latest version of Perl
3.  Hack stage to test on multiple versions of Perl

### Default Test Stage Matrix

If you only want to test on Windows with [Strawberry Perl], and don't care about
any other OS, this is the way to go. First, set the OS, language, and matrix of
[Strawberry Perl versions] via Environment variables :

``` yaml
os: windows
language: shell
env:
  - PERL_VERSION: 5.28.1.1
  - PERL_VERSION: 5.26.3.1
```

Next, use [Chocolatey] to install a specific version of [Strawberry Perl]
and add it to the path:

``` yaml
before_install:
  - cinst -y strawberryperl --version $PERL_VERSION
  - export "PATH=/c/Strawberry/perl/site/bin:/c/Strawberry/perl/bin:/c/Strawberry/c/bin:$PATH"
```

And finally, install any dependencies and then build and test your project as
usual:

``` yaml
install:
  - cpanm --notest --installdeps .
script:
  - perl Makefile.PL
  - gmake
  - gmake test
  ```

### Single Windows Stage

If you already use the standard Travis environment for a matrix of [Perl
versions], and just want to test your project against a single version of Perl
on Windows, Add a custom stage, perhaps named "Windows", like so:

``` yaml
jobs:
  include:
    - stage: Windows
      os: windows
      language: shell
      before_install:
        - cinst -y strawberryperl
        - export "PATH=/c/Strawberry/perl/site/bin:/c/Strawberry/perl/bin:/c/Strawberry/c/bin:$PATH"
      install:
        - cpanm --notest --installdeps .
      script:
        - perl Makefile.PL
        - gmake
        - gmake test
```

Note that the `before_install` phase installs the latest version of [Strawberry
Perl], without regard to any environment variables.  All the other phases are
the same as the default stage.

### Windows Matrix Stage

To test on multiple versions of Perl on Windows but still keep the default
"Test" stage on Linux, it's possible, although build stages do not ([yet]?)
support matrix expansion. Instead, we have to rely on [a workaround] where
multiple stages with the same name are considered a matrix. It makes for
a lot of redundancy in the [`.travis.yml`], but it works:

``` yaml
jobs:
  include:

    # First instance of "stage: Strawberry" tests 5.28.1.1.
    - stage: Strawberry
      os: windows
      language: shell
      env:
      - PERL_VERSION: 5.28.1.1
      before_install:
        - cinst -y strawberryperl --version $PERL_VERSION
        - export "PATH=/c/Strawberry/perl/site/bin:/c/Strawberry/perl/bin:/c/Strawberry/c/bin:$PATH"
      install:
        - cpanm --notest --installdeps .
      script:
        - perl Makefile.PL
        - gmake
        - gmake test

    # Second instance of "stage: Strawberry" tests 5.26.3.1.
    - stage: Strawberry
      os: windows
      language: shell
      env:
      - PERL_VERSION: 5.26.3.1
      before_install:
        - cinst -y strawberryperl --version $PERL_VERSION
        - export "PATH=/c/Strawberry/perl/site/bin:/c/Strawberry/perl/bin:/c/Strawberry/c/bin:$PATH"
      install:
        - cpanm --notest --installdeps .
      script:
        - perl Makefile.PL
        - gmake
        - gmake test
```

Caveats
-------

*   The [Travis CI Windows Build Environment] is in an early release and subject
    to change. Be sure to consult the [known issues] when you run into problems.
*   The shell environment on is [Git Bash], not `cmd.exe` or PowerShell (though
    Travis is "[looking into adding first class Powershell support very soon]")
*   The `prove` utility does not currently work, perhaps because `prove.bat` is
    installed but [Git Bash] requires just `prove`? That's just a guess
    ([bug report]).

  [Strawberry Perl]: http://strawberryperl.com
  [Travis CI Windows Build Environment]: https://docs.travis-ci.com/user/reference/windows/
  [`.travis.yml`]: ./.travis.yml
  [Strawberry Perl versions]: https://chocolatey.org/packages/StrawberryPerl#versionhistory
  [cpanminus]: https://github.com/miyagawa/cpanminus
  [Chocolatey]: https://chocolatey.org
  [Perl versions]: https://docs.travis-ci.com/user/languages/perl/
    "Travis CI: Building a Perl Project"
  [yet]: https://github.com/travis-ci/travis-ci/issues/8295
    "Support Matrix expansion per-stage in Build Stages feature"
  [a workaround]: https://github.com/travis-ci/travis-ci/issues/8295#issuecomment-325044011
  [known issues]: https://travis-ci.community/t/current-known-issues-please-read-this-before-posting-a-new-topic/264
    "Travis CI Community: “Current known \[Windows\] issues — Please read this before posting a new topic”"
  [Git Bash]: https://gitforwindows.org
  [looking into adding first class Powershell support very soon]:
    https://docs.travis-ci.com/user/reference/windows/#powershell
  [bug report]: https://rt.cpan.org/Public/Bug/Display.html?id=128221
    "Bug #128221 for Perl-Dist-Strawberry: Prove Perl Script not Installed"

Author
------

[David E. Wheeler](https://justatheory.com/)
