require 'yaml'

files = `ack -L 'Tag' cfn-templates/*.yaml`.split(' ')

files.map do |file|
  YAML.load_file(file)['Resources'].values.first['Type']
end.reduce({}) do |h, n|
  h[n.gsub(/\AAWS::/, '').gsub('::', '') + "Rule"] = n
  h
end.each_pair do |file_name, namespace|
  `ruby ./write_rule.rb #{file_name} #{namespace}`
end
