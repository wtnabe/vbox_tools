# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{vbox_tools}
  s.version = "0.1.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["wtnabe"]
  s.date = %q{2009-08-15}
  s.default_executable = %q{vbox_tools}
  s.description = %q{create VirtualBox configuration file, and force shutdown virtual machines}
  s.email = %q{wtnabe@gmail.com}
  s.executables = ["vbox_tools"]
  s.extra_rdoc_files = ["README", "ChangeLog"]
  s.files = ["README", "ChangeLog", "Rakefile", "bin/vbox_tools", "bin/vbox_tools.bat", "test/test_helper.rb", "test/vbox_tools_test.rb", "lib/vbox_tools.rb"]
  s.homepage = %q{}
  s.rdoc_options = ["--title", "vbox_tools documentation", "--charset", "utf-8", "--opname", "index.html", "--line-numbers", "--main", "README", "--inline-source", "--exclude", "^(examples|extras)/"]
  s.require_paths = ["lib"]
  s.requirements = ["rake"]
  s.rubyforge_project = %q{}
  s.rubygems_version = %q{1.3.4}
  s.summary = %q{create VirtualBox configuration file, and force shutdown virtual machines}
  s.test_files = ["test/vbox_tools_test.rb"]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<rake>, [">= 0"])
    else
      s.add_dependency(%q<rake>, [">= 0"])
    end
  else
    s.add_dependency(%q<rake>, [">= 0"])
  end
end
