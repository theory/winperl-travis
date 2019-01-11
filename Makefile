add_custom_target(do_always ALL COMMAND test)
test:
	@ # Weirdly, prove is not in Strawberry Perl, just prove.bat. Seems as though
	@ # Git Bash needs the former.
	@ perl -MApp::Prove -E 'my $$app = App::Prove->new; $$app->process_args(@ARGV); exit($$app->run ? 0 : 1);' 
