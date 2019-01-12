Travis CI Windows + Strawberry Perl
===================================

[![Build Status](https://travis-ci.com/theory/winperl-travis.png)](https://travis-ci.com/theory/winperl-travis)

A simple sample project for installing dependencies and running tests
with [Strawberry Perl] on the [Travis CI Windows Build Environment]. See
the [`.travis.yml](./.travis.yml) file for the working code. The steps
are:

*   Configure the [Strawberry Perl versions] to test
*   Install Strawberry Perl
*   Add Strawberry Perl to the path
*   Install dependencies with [cpanminus]
*   Build and test your Perl project as usual

[Strawberry Perl]: http://strawberryperl.com
[Travis CI Windows Build Environment]: https://docs.travis-ci.com/user/reference/windows/
[Strawberry Perl versions]: https://chocolatey.org/packages/StrawberryPerl#versionhistory
[cpanminus]: https://github.com/miyagawa/cpanminus
