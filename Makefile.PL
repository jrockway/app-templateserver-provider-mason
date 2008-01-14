use inc::Module::Install;

name 'App-TemplateServer-Provider-Mason';
all_from 'lib/App/TemplateServer/Provider/Mason.pm';

build_requires 'Catalyst::Runtime';
build_requires 'Test::WWW::Mechanize::Catalyst';
build_requires 'Test::More';
build_requires 'ok';

WriteAll();
