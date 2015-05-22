# Riak.app Enable Search
This repo is a set of helpful tidbits to play around with Apache Solr integration in Riak using the Riak.app ([source](https://github.com/basho-labs/riak-app) | [download](http://riak-tools.s3.amazonaws.com/Riak210.dmg)).

## How to Start

I'm pairing this repo with a tutorial focused on using Riak with Ruby on OS X. These scripts will not work otherwise :bowtie:

1. Install [the Riak.app](http://riak-tools.s3.amazonaws.com/Riak210.dmg). I've tested using the 2.1.0 build linked here.
1. Make sure to install the riak gem using `gem install riak-client`
1. Clone this repository locally
1. Run the `setup.sh` script by running `bash setup.sh`
1. Run the `populate-search.rb` to setup your bucket for search indexing and to add some data to search

Now you can write code that searches for these files! For instance, play around in `irb`:

```ruby
$ irb
>> require 'riak'
=> true
>> client = Riak::Client.new(:pb_port => 8087)
=> #<Riak::Client [#<Node 127.0.0.1:8087>]>
>> fetched = client.search('libraries','maintainer_s:Basho')
=> {"max_score"=>1.2336148023605347, "num_found"=>6, "docs"=>[{"score"=>"1.23361480000000001134e+00",
... # more output here #
>> fetched["docs"].each {|x| puts x["name_s"]}
Ruby Client
Python Client
Java Client
PHP Client
Node.js Client
.NET Client
R Client
Go Client
```

## Goal
It's nice when code has a point. Here's my goal.

### setup.sh

This script enables search for your Riak.app, which defaults to `search = off`. It will turn the Riak instance off and on again to make sure there's a reboot. 

**Note:** the Riak app will be online after this script completes. Don't forget to use it or turn it off :+1:

### populate-search.rb

This script creates our Apache Solr search index, named `libraries`, sets our bucket `coding-with-riak` to use that index and then populates the bucket with some client JSON objects. It may be better to decouple these first two from the population part, but this works for now.

## Get Involved

There's a lot of room to make more simple tutorials on using Riak features. I would love to see you extend upon this one, add to [The Taste of Riak](https://github.com/basho/taste-of-riak) tutorials or build an application that highlights some functionality you appreciate. 

## License and Authors

[MIT license](LICENSE) - use as you will.

* **Author**: Matthew Brender ([Twitter](http://twitter.com/mjbrender) | [Blog](http://neckbeardinfluence.com))