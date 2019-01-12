use ExtUtils::MakeMaker;
WriteMakefile(
    NAME      => 'Win32::Travis',
    VERSION   => '1.0',
    ABSTRACT  => 'Simple demo module',
    PREREQ_PM => {
        'URI::db' => 0,
    }
);
