use ExtUtils::MakeMaker;
WriteMakefile(
    NAME      => 'Win32::Travis',
    VERSION   => '1.0',
    ABSTRACT  => 'Simple demo distribution',
    PREREQ_PM => {
        'CPAN::Test::Dummy::Perl5::Make' => 0,
    }
);
