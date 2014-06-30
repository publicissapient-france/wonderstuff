Master branch: [![Build Status](https://travis-ci.org/xebia-france/wonderstuff.png?branch=master)]
(https://travis-ci.org/xebia-france/wonderstuff)
# Wonderstuff cookbook

This cookbook is an implementation of the wonderstuff example from the
book [Test-Driven Infrastructure with Chef, 2nd Edition](http://shop.oreilly.com/product/0636920030973.do)
by Stephen Nelson-Smith .

The goal was to play around with the example and to provide an as fast and automated environment as possible
with continuous integration and from the ground up automated testing of a cookbook.

# The foundations

## A sane development environment

To setup a sane development environment on my Mac, I found the following article useful:
http://misheska.com/blog/2013/12/26/set-up-a-sane-ruby-cookbook-authoring-environment-for-chef/#install-bundler---mac-os-x .

## Local VMs management

To work on the cookbooks locally, you need at least to have [`VirtualBox`](https://www.virtualbox.org/)
and [`Vagrant`](http://www.vagrantup.com/) installed. (See article in next section for instructions) 

## Cookbook dependencies

The dependencies on other cookbooks are handled using [`Berkshelf`](http://berkshelf.com/) (version `3.0.0.betaX` at
the time of this writing)

I found this article useful to get started:
http://misheska.com/blog/2013/06/16/getting-started-writing-chef-cookbooks-the-berkshelf-way/

Note: there is a mention in this article that [`vagrant-berkshelf` is being deprecated]
(https://sethvargo.com/the-future-of-vagrant-berkshelf/) and that `test-kitchen`
should be used instead. Just follow the lead of the article.

# Tests

This repo implements the tests of the book (Chapter "Acceptance Testing: Cucumber and Leibniz" > "Example") using:

* [`ChefSpec`](https://github.com/sethvargo/chefspec) as a unit test tool
* [`ServerSpec`](http://serverspec.org/) as an integration test tool

`ChefSpec` tests are run using:
```
bundle exec rspec -fd
```

`ServerSpec` tests are run using one of the following options:
```
bundle exec kitchen test   # destroys and rebuilds completely the VMs before doing the tests
or
bundle exec kitchen verify # uses existing VMs if exists. Carefull: recipe changed => kitchen converge
```

I did not implement the tests using [`Leibniz`](https://github.com/Atalanta/leibniz), (or rather
[I did](https://github.com/esciara/wonderstuff/tree/6bbbd847fc71258e09e92070df67497b109a5a51) but then
removed it) as the tool is not being actively developed or supported
(code untouched since 5 months as the time of this writing and only supports `test-kitchen 1.0.0.alpha`).

The tests are run using [`test-kitchen`](https://github.com/test-kitchen/test-kitchen) (version `1.2.1` at
the time of this writing).

I also tried to build up the fastest and most testing friendly environment for Chef Cookbooks development, hence I
also added to the mix:

* [`Foodcritic`](http://acrmp.github.io/foodcritic/) as a lint tool
* [`Rubocop`](https://github.com/bbatsov/rubocop) as a code analyser
* [`Guard`](https://github.com/guard/guard) to have all tests run locally as soon as a file is changed

I found the following series of articles useful to set this up:
https://micgo.net/automating-cookbook-testing-with-test-kitchen-berkshelf-vagrant-and-guard/

`Foodcritic` checks are run using:
```
bundle exec foodcritic -f any .
```

`Rubocop` checks are run using:
```
bundle exec rubocop
```

`Guard` should really be started on a different session using:
```
bundle exec guard
```

# Continuous Integration

(As a note, `Guard`, which is mentioned above, could be considered a local continuous integration system)

To make sure that committed code is tested, and since we are on GitHub, I implemented the use of [`Travis`]
(https://travis-ci.org/esciara/wonderstuff) which is free for public repositories.

But since I concluded [after a little searching](https://github.com/bflad/chef-confluence/issues/5#issuecomment-40249093)
that `test-kitchen` can probably not really run a VM inside the `Travis` VM,
I looked on how to have VMs build from scratch to validate the cookbooks by running all the tests on each push.

I found a great example in https://github.com/opscode-cookbooks/tomcat/blob/master/TESTING.md and am using
cloud VMs from https://www.digitalocean.com/ . I have not optimised anything yet, but it turns out that spinning
a VM for a full test costs $0.01 (So that is the amount per target system per push).

Note: I did not add [`travis-lint`](https://github.com/travis-ci/travis-lint) as recommended in
http://docs.travis-ci.com/user/travis-lint/ as dependencies force the installation of version `1.1.0` of `test-kitchen`
instead of latest version. Also, it seems `travis-lint` is deprecated (as written on the top of 
[its GitHub page](https://github.com/travis-ci/travis-lint)) and
[`travis-yaml`](https://github.com/travis-ci/travis-yaml) should be used instead. However, `travis-yaml` does not seem
to have a cli... So I did not bother adding it to the system and use http://yaml.travis-ci.org/ instead to
check manually my `.travis.yml` files.

# Other Goodies

To add to this, and to make sure no stone remains unturned, I added to my environment the following:

* [a neat combination - even though dubbed "total experiment and hack, looks nasty, could be awesome" -]
(https://gist.github.com/fnichol/7551540)
of local caching with [`polipo`](https://github.com/jech/polipo) and the use of `.kitchen.local.yml` to speed up chef
install process on the VMs. (For full info on all options,
see https://github.com/test-kitchen/test-kitchen/issues/315#issuecomment-31888512)
* [`Hookup`](https://github.com/tpope/hookup), which uses `git` hooks to make sure bundling is done when the
`Gemfile` is changed

# To-do list

Items that need to be done:

* Create and use a `rake` file (a good example of use could be
https://github.com/opscode-cookbooks/tomcat/blob/master/Rakefile)

Need to check whether the following are worth using:

* [`knife cookbook test`](http://docs.opscode.com/knife_cookbook.html#test), (mentioned in the book) see:
  * http://technology.customink.com/blog/2012/08/03/testing-chef-cookbooks/
  * http://www.neverstopbuilding.com/knife-testing
  * http://www.nathenharvey.com/blog/2012/07/06/mvt-knife-test-and-travisci
* [`Tailor`](https://github.com/turboladen/tailor) (mentioned in http://acrmp.github.io/foodcritic/ and
* [`Strainer`](https://github.com/customink/strainer) (mentioned in http://slidedeck.io/paulczar/TDD-with-chef-and-strainer)
* [`Docker`](https://www.docker.io/) with `test-kitchen` on a linux machine to speed up things
* Setting up a [`Jenkins`](http://jenkins-ci.org/0 server coupled with `Docker`? Found this interesting cookbook:
http://www.cryptocracy.com/blog/2014/01/03/cooking-with-jenkins-test-kitchen-and-docker/

# Suggestions

Suggestions are welcome. Please use issues.

# Contributing

Please use standard Github issues/pull requests and if possible. All work should have automated test associated to it.

# Author

Author:: Emmanuel Sciara (<emmanuel.sciara@gmail.com>)

```text
Copyright (C) 2014, Emmanuel Sciara

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

   http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```
