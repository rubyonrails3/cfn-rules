current_directory_path = __dir__

template_path = "#{current_directory_path}/lib/unum-rules/template.rb"

file_content = File.read(template_path)

klass_name = ARGV[0]
file_name = "#{klass_name}.rb"
namespace = ARGV[1]

new_content = file_content.sub(':KLASS_NAME', klass_name)
  .sub(':KLASS_RULE_ID', klass_name.upcase)
  .sub(':RESOURCE_TYPE', namespace)


new_file_path = "#{current_directory_path}/lib/unum-rules/#{file_name}"
File.write(new_file_path, new_content)
