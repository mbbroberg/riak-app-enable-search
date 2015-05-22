# populates information and gets you ready to search

require 'riak'
port = 8087
schema = '_yz_default'
index = 'libraries'
bucket_name = 'coding-with-riak'

begin
    puts "connecting to the cluster over #{port}."
    client = Riak::Client.new(:pb_port => port)
    puts "Pinging cluster to confirm connection."

    if client.ping
        puts "Okay, we're connected."
    end

    puts "Creating the #{index} index using #{schema} Solr schema"
    client.create_search_index(index, schema)

    puts "Setting up the bucket #{bucket_name} to be indexed using #{index}"
    bucket = client.bucket(bucket_name)

    # The ruby client (2.1.0) won't let me set this property for some reason
    # bucket.properties = {'search_index' => index}
    # using riak-admin command instead
    `/Applications/Riak.app/Contents/Resources/riak-2.1.0/bin/riak-admin bucket-type update clients '{"props":{"search_index":"libraries"}}'`

    puts "Time to write all the data!"
    puts "We're using bucket.new() to add new data"

    val = bucket.new('ruby')
    val.data = {'name_s'=>'Ruby Client',
                'maintainer_s'=>'Basho',
                'popular_b'=>true,
                'url'=>'https://github.com/basho/riak-ruby-client'
                }
    val.store

    val = bucket.new('python')
    val.data = {'name_s'=>'Python Client',
                'maintainer_s'=>'Basho',
                'popular_b'=>true,
                'url'=>"https://github.com/basho/riak-python-client"
                }
    val.store

    val = bucket.new('go')
    val.data = {'name_s'=>'Go Client',
                'maintainer_s'=>'Community',
                'popular_b'=>true,
                'url'=>'https://github.com/basho-labs/riak-go-client'
                }
    val.store

    val = bucket.new('r')
    val.data = {'name_s'=>'R Client',
                'maintainer_s'=>'Community',
                'popular_b'=>false, 
                'url'=>'https://github.com/basho-labs/riak-r-client'
                }
    val.store

    val = bucket.new('java')
    val.data = {'name_s'=>'Java Client',
                'maintainer_s'=>'Basho',
                'popular_b'=>true,
                'url'=>'https://github.com/basho-labs/riak-java-client'
                }
    val.store

    val = bucket.new('php')
    val.data = {'name_s'=>'PHP Client',
                'maintainer_s'=>'Basho',
                'popular_b'=>false, 
                'url'=>'https://github.com/basho-labs/riak-php-client'
                }
    val.store

    val = bucket.new('nodejs')
    val.data = {'name_s'=>'Node.js Client',
                'maintainer_s'=>'Basho',
                'popular_b'=>true, 
                'url'=>'https://github.com/basho-labs/riak-nodejs-client'
                }
    val.store

    val = bucket.new('dotnet')
    val.data = {'name_s'=>'.NET Client',
                'maintainer_s'=>'Basho',
                'popular_b'=>true, 
                'url'=>'https://github.com/basho-labs/riak-dotnet-client'
                }
    val.store

    puts "All done! We stored 8 different clients with 4 data values."
    puts "Let's list out all the values to double check:"
    puts bucket.keys
    puts "^ You should see 8 different values"

rescue 
    puts "something went wrong."
    puts "abandoning ship!"
    exit
end