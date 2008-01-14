use inc::Module::Install;

name 'App-TemplateServer-Provider-Mason';
all_from 'lib/App/TemplateServer/Provider/Mason.pm';

requires 'App::TemplateServer' => '0.01';
requires 'HTML::Mason';
build_requires 'Test::More';
build_requires 'ok';

WriteAll();
