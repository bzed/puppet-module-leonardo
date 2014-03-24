# Example using exported resources
# look at exported.pp to see how to export them

  File <<| tag == "env_leonardo_$environment" |>> {}
  Leonardo::Dashboard <<| tag == "env_$environment" |>> {}
  Leonardo::Graph <<| tag == "env_$environment" |>> {}
